class LandingPageController < ApplicationController
  layout 'landing_page'

  def index
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_dashboard_path
      elsif current_user.adopter?
        redirect_to adopter_dashboard_path
      elsif current_user.shelter?
        redirect_to shelter_dashboard_path
      else
        render :index
      end
    else
      render :index
    end
  end
end
