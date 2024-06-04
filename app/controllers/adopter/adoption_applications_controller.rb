class Adopter::AdoptionApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_adoption_application, only: [:show, :destroy]

  def index
    @adoption_applications = current_user.adopter.adoption_applications
  end

  def show
    # before_action set_adoption_application heree
  end

  def new
    @adoption_application = AdoptionApplication.new
  end

  def create
    adopter = Adopter.find_by(user_id: current_user.id)
    @adoption_application = AdoptionApplication.new(adoption_application_params)
    @adoption_application.application_date = Date.today
    @adoption_application.adopter_id = adopter.id
  
    existing_application = AdoptionApplication.find_by(adopter_id: adopter.id, pet_id: @adoption_application.pet_id)
  
    if existing_application
      redirect_to adopter_adoption_applications_path, alert: 'You have an existing adoption application for this pet.'
    else
      if @adoption_application.save
        redirect_to adopter_adoption_applications_path, notice: 'Adoption application was successfully created.'
      else
        render :new
      end
    end
  end
  

  def destroy
    # @adoption_application is set in before_action
    @adoption_application.destroy
    redirect_to adopter_adoption_applications_path, notice: "Application has been withdrawn."
  end

  private

  def set_adoption_application
    @adoption_application = AdoptionApplication.find(params[:id])
  end

  def adoption_application_params
    params.require(:adoption_application).permit(:adopter_id, :pet_id, :status, :application_date)
  end
end
