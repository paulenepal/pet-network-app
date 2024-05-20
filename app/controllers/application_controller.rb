class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :username, :location, :role,
        adopter_attributes: [:preference, :first_name, :last_name],
        shelter_attributes: [:name, :address, :phone_number, :website, :description]
      ])
    end
  
    def ensure_admin
      unless current_user&.admin?
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  
  end