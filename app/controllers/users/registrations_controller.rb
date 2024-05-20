# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:new, :create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({})
    resource.build_adopter unless params[:role] == 'shelter'  # using unless here to set 'adopter field' as default sign form 
    resource.build_shelter if params[:role] == 'shelter'
    respond_with resource
  end

  # POST /resource
  def create
    super do |resource|
      if params[:user][:role] == 'adopter'
        resource.build_adopter(adopter_params)
      elsif params[:user][:role] == 'shelter'
        resource.build_shelter(shelter_params)
      end
      resource.save
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  private

  def adopter_params
    params.require(:user).fetch(:adopter_attributes, {}).permit(:first_name, :last_name, :preference)
  end

  def shelter_params
    params.require(:user).fetch(:shelter_attributes, {}).permit(:name, :address, :phone_number, :website, :description)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :username, :location, :role,
      adopter_attributes: [:preference, :first_name, :last_name],
      shelter_attributes: [:name, :address, :phone_number, :website, :description]
    ])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
