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

      if resource.save
        # Make API call to Sendbird to create user
        sendbird_response = SendbirdService.register_user(resource)

      #  if sendbird_response && sendbird_response.success?
      #   Rails.logger.debug "User created in Sendbird successfully"
      #   else
      #   if sendbird_response.nil?
      #     Rails.logger.error "Failed to create user in Sendbird: No response received"
      #   else
      #     Rails.logger.error "Failed to create user in Sendbird: #{sendbird_response.body}"
      #   end
        if sendbird_response
          Rails.logger.debug "User created in Sendbird successfully"
        else
          Rails.logger.error "Error registering user with Sendbird: #{response.status} - #{response.body}"
          begin
            response_body = JSON.parse(response.body)
            Rails.logger.error "Sendbird Error: #{response_body['message']} (Code: #{response_body['code']})"
          rescue JSON::ParserError
            Rails.logger.error "Non-JSON response body: #{response.body}"
          end
          nil
        end

        UserMailer.admin_approval_email(resource).deliver_now
        UserMailer.pending_approval_email(resource).deliver_now
      end
    end
  end

  #This is for inviting new users, both adopters and shelters
  def new_invited_user
    @invited_user = User.find_by_invitation_token(params[:invitation_token], true)
    if @invited_user
      Rails.logger.debug "Invited user found: #{@invited_user.email}"
      @invited_user.build_shelter if @invited_user.shelter? && @invited_user.shelter.nil?
      @invited_user.build_adopter if @invited_user.adopter? && @invited_user.adopter.nil?
      render 'devise/registrations/new_invited_user'
    else
      Rails.logger.debug "Invalid or expired invitation token: #{params[:invitation_token]}"
      redirect_to root_path, alert: 'Invalid or expired invitation token.'
    end
  end

  def create_invited_user
    Rails.logger.debug "Params received: #{params.inspect}"
    @invited_user = User.find_by_invitation_token(params[:user][:invitation_token], true)
    Rails.logger.debug "Invited user found: #{@invited_user.inspect}" if @invited_user
    Rails.logger.debug "No invited user found for token: #{params[:user][:invitation_token]}" unless @invited_user
    
    if @invited_user
      @invited_user.approved = true
      if @invited_user.update(user_params)
        @invited_user.accept_invitation!
        sign_in(@invited_user)
        redirect_to root_path, notice: 'Your account has been successfully created.'
      else
        Rails.logger.debug "Update failed: #{@invited_user.errors.full_messages.join(', ')}" if @invited_user
        render 'devise/registrations/new_invited_user'
      end
    else
      render 'devise/registrations/new_invited_user', alert: 'Invalid or expired invitation token.'
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

  def user_params
    params.require(:user).permit(
      :email, :username, :password, :password_confirmation, :invitation_token, :location,
      shelter_attributes: [:id, :name, :address, :phone_number, :website, :description],
      adopter_attributes: [:id, :preference, :first_name, :last_name]
    )
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

