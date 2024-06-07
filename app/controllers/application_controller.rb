class ApplicationController < ActionController::Base
  def index
    @users = case current_user.role.to_sym
             when :admin
               User.includes(:adopter).where(role: :admin).map(&:full_name)
             when :shelter
               User.includes(:adopter).where(role: :shelter).map(&:full_name)
             when :adopter
               User.includes(:shelter).where(role: :adopter).map(&:username)
             end
  end
  rescue_from User::NotAuthorized, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Access denied.'
    redirect_to(root_path)
  end
  
end