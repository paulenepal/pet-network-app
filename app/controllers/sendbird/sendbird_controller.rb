# app/controllers/sendbird/sendbird_controller.rb
module Sendbird
  class SendbirdController < ApplicationController
    def create_user_to_sendbird(user)
      response = SendbirdService.register_user(user)
      response.present?  # Return true if response is present, false otherwise
    end

    def create_group_channel_to_sendbird
      target_user_id = params[:user_id]
      current_user_id = current_user.sendbird_id
  
      sendbird_service = SendbirdService.new
      channel_info = sendbird_service.create_group_channel(current_user_id, target_user_id)
  
      render json: channel_info
    end
  end
end
