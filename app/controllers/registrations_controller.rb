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

  private

  def adopter_params
    params.require(:user).require(:adopter).permit(:first_name, :last_name, :preference)
  end

  def shelter_params
    params.require(:user).require(:shelter).permit(:name, :address, :phone_number, :website, :description)
  end

end