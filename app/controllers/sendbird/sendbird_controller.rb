# app/controllers/sendbird/sendbird_controller.rb
module Sendbird
  class SendbirdController < ApplicationController
    def create_user_to_sendbird(user)
      response = SendbirdService.register_user(user)
      response.present?  # Return true if response is present, false otherwise
    end

    # def list_users
    #   @users = SendbirdService.new.get_list_users
    #   if @users.present? && @users.is_a?(Array)
    #     render 'sendbird/list_users', locals: { users: @users }
    #   else
    #     flash[:alert] = 'Failed to fetch users from Sendbird'
    #     redirect_to root_path
    #   end
    # end

    def create_group_channel_to_sendbird
      target_user_id = params[:user_id]
      current_user_id = current_user.sendbird_id
  
      sendbird_service = SendbirdService.new
      channel_info = sendbird_service.create_group_channel(current_user_id, target_user_id)
  
      render json: channel_info
    end

    def send_message_to_sendbird
      channel_url = params.dig(:sendbird,:channel_url)
      message = params[:user_id]
      user_id = current_user.sendbird_id

      sendbird_service = SendbirdService.new
      channel_info = sendbird_service.send_message(channel_url, user_id, message)

      Rails.logger.debug "Sendbird API response: #{channel_info.inspect}" # Log the response for debugging

      # Parse the JSON response
      parsed_channel_info = JSON.parse(channel_info, symbolize_names: true)

      if parsed_channel_info.is_a?(Hash) && parsed_channel_info[:channel_url]
        render json: { channel_url: parsed_channel_info[:channel_url] }
      else
        render json: { error: 'Failed to send message' }, status: :unprocessable_entity
      end
    end

    def fetch_messages
      channel_url = params[:channel_url]
      message_ts = params[:message_ts]
      message_id = params[:message_id]

      sendbird_service = SendbirdService.new
      messages_response = sendbird_service.fetch_messages(channel_url, message_ts: message_ts, message_id: message_id)
      puts messages_response
      if messages_response && messages_response[:messages]
        render json: { messages: messages_response[:messages] }
      else
        render json: { error: 'Failed to fetch messages' }, status: :unprocessable_entity
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

  end
end
