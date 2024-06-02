module ShelterNamespace
  class AdoptionApplicationsController < BaseController
    before_action :set_adoption_application, only: [:show, :update, :approve, :deny, :pending]

    def index
      @adoption_applications = current_user.shelter.adoption_applications
                                          .includes(:adopter, :pet)
                                          .joins(adopter: :user)
                                          .order('adoption_applications.application_date ASC')
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
      ActiveRecord::Base.transaction do
        @adoption_application.update!(status: :approved)
        update_pet_status(@adoption_application.pet)
        AdoptionApplicationMailer.application_approved(@adoption_application).deliver_later
      end
      flash[:notice] = "Adoption application approved. Email sent"
      redirect_to shelter_namespace_adoption_applications_path
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = "Unable to approve adoption application: #{e.message}"
      redirect_to shelter_namespace_adoption_applications_path
    end

    def deny
      ActiveRecord::Base.transaction do
        @adoption_application.update!(status: :rejected)
        update_pet_status(@adoption_application.pet)
        AdoptionApplicationMailer.application_denied(@adoption_application).deliver_later
      end
      flash[:notice] = "Adoption application rejected. Email sent"
      redirect_to shelter_namespace_adoption_applications_path
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = "Unable to reject adoption application: #{e.message}"
      redirect_to shelter_namespace_adoption_applications_path
    end

    def pending
      ActiveRecord::Base.transaction do
        @adoption_application.update!(status: :submitted)
        update_pet_status(@adoption_application.pet)
        AdoptionApplicationMailer.application_pending(@adoption_application).deliver_later
      end
      flash[:notice] = "Adoption application pending. Email sent"
      redirect_to shelter_namespace_adoption_applications_path
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = "Unable to set adoption application to pending: #{e.message}"
      redirect_to shelter_namespace_adoption_applications_path
    end

    private

    def set_adoption_application
      @adoption_application = AdoptionApplication.find(params[:id])
    end

    def adoption_application_params
      params.require(:adoption_application).permit(:status, :adopter_id, :pet_id, :application_date)
    end

    def update_pet_status(pet)
      if pet.adoption_applications.approved.exists?
        pet.update!(adoption_status: :adopted)
      elsif pet.adoption_applications.submitted.exists?
        pet.update!(adoption_status: :pending)
      else
        pet.update!(adoption_status: :available)
      end
    end
  end
end
