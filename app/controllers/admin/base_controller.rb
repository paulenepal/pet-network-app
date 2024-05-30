module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin

    private

    def ensure_admin
      if current_user.nil?
        puts "Current user is nil"
      elsif !current_user.admin?
        puts "Current user is not an admin"
      end

      unless current_user&.admin?
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  end
end
