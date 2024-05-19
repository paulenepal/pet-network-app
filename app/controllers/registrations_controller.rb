class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    resource.build_adopter unless params[:role] == 'shelter'
    resource.build_shelter if params[:role] == 'shelter'
    respond_with resource
  end

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

  # New and create actions for inviting shelters
  def new_shelter
    @user = User.find_by(invitation_token: params[:invitation_token])
    @user.build_shelter
    respond_with @user
  end

  def create_shelter
    @user = User.find_by(invitation_token: params[:user][:invitation_token])
    if @user.update(sign_up_params.merge(role: :shelter, approved: true))
      redirect_to root_path, notice: 'Shelter registered and approved successfully.'
    else
      Rails.logger.debug(@user.errors.full_messages)
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new_shelter
    end
  end

  private

  def adopter_params
    params.require(:user).require(:adopter).permit(:first_name, :last_name, :preference)
  end

  def shelter_params
    params.require(:user).require(:shelter).permit(:name, :address, :phone_number, :website, :description)
  end

  # Sign up params for create_shelter method
  def sign_up_params
    params.require(:user).permit(:email, :password, :username, :location, :invitation_token, :role, shelter_attributes: [:name, :address, :phone_number, :website, :description])
  end

end