module ShelterNamespace
  class AdoptionApplicationsController < BaseController
    before_action :set_adoption_application, only: [:show, :update, :approve, :deny]


  def index
    @adoption_applications = current_user.shelter.adoption_applications.includes(:adopter, :pet)
  end

  def show
  end



  def update
    if @adoption_application.update(adoption_application_params)
      flash[:notice] = "Adoption application updated successfully"
      redirect_to shelter_namespace_adoption_application_path(@adoption_application)
    else
      render :edit
    end
  end

  def approve
    @adoption_application.update(status: :approved)
    flash[:notice] = "Adoption application approved"
    redirect_to shelter_namespace_adoption_applications_path
  end

  def deny
    @adoption_application.update(status: :denied)
    flash[:notice] = "Adoption application denied"
    redirect_to shelter_namespace_adoption_applications_path
  end

  private

  def set_adoption_application
    @adoption_application = AdoptionApplication.find(params[:id])
  end

  def adoption_application_params
    params.require(:adoption_application).permit(:status, :adopter_id, :pet_id, :application_date)
  end
end
end
