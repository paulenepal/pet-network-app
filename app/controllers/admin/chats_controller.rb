# app/controllers/admin/chats_controller.rb
class Admin::ChatsController < ApplicationController
    before_action :set_sendbird_env

    def create
      @chat = Chat.new(chat_params)
      if @chat.save
        # Broadcast the chat message to a WebSocket channel (optional)
        # ActionCable.server.broadcast 'chat_channel', message: @chat.message
        render json: @chat, status: :created
      else
        render json: @chat.errors, status: :unprocessable_entity
      end
    end
  
    private

    private

  def set_sendbird_env
    @sendbird_app_id = ENV['SENDBIRD_APP_ID']
  end
  
    def chat_params
      params.require(:chat).permit(:message, :user_id)
    end
  end
  