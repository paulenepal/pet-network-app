# app/controllers/shelters_controller.rb
class SheltersController < ApplicationController
  before_action :authenticate_user!  # Ensure user is logged in

  def index
    @shelter = current_user.shelter
    @pets = @shelter&.pets || []  # Safe navigation to handle nil shelter
  end
end
