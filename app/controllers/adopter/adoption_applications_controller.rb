class Adopter::AdoptionApplicationsController < ApplicationController
  before_action :set_adoption_application, only: [:show, :destroy]

  def index
    @adoption_applications = AdoptionApplication.all
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
      respond_to do |format|
        format.html { redirect_to adopter_adoption_applications_path, alert: 'You have an existing adoption application for this pet.' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:modal, partial: "form", locals: { adoption_application: @adoption_application, error: 'You have an existing adoption application for this pet.' })
        end
      end
    else
      respond_to do |format|
        if @adoption_application.save
          format.html { redirect_to adopter_adoption_applications_path, notice: 'Adoption application was successfully created.' }
          format.turbo_stream do
            render turbo_stream: turbo_stream.append(:adoption_applications, partial: "adoption_applications/adoption_application", locals: { adoption_application: @adoption_application })
          end
        else
          format.html { render :new }
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(:modal, partial: "form", locals: { adoption_application: @adoption_application })
          end
        end
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
