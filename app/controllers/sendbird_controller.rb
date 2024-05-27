# app/controllers/sendbird_controller.rb
class SendbirdController < ApplicationController
    before_action :authenticate_user!
  
    def create_channel
      response = SendbirdService.create_channel(current_user.id, params[:user_id])
      if response.success?
        render json: { channel_url: response.body['channel_url'] }, status: :ok
      else
        render json: { error: response.body }, status: :unprocessable_entity
      end
    end
  end
  