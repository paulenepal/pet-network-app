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
end