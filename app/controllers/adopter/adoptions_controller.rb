class Adopter::AdoptionsController < ApplicationController
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
    @adoption_application = AdoptionApplication.new(adoption_application_params)
    @adoption_application.application_date = Date.today
    @adoption_application.adopter_id = Adopter.find_by(user_id: current_user.id).id

    if @adoption_application.save
      respond_to do |format|
        format.turbo_stream do
          @adoption = @adoption_application
        end
        format.html { redirect_to adopter_adoptions_path, notice: 'Adoption application was successfully created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace(:modal, partial: "form", locals: { adoption_application: @adoption_application }) }
        format.html { render :new }
      end
    end
  end

  def destroy
    # before_action set_adoption_application heree
    @adoption_application.destroy
    respond_to do |format|
      format.html { redirect_to adopter_adoptions_path, notice: 'Application was successfully destroyed.' }
      format.turbo_stream
    end
  end

  private

  def set_adoption_application
    @adoption_application = AdoptionApplication.find(params[:id])
  end

  def adoption_application_params
    params.require(:adoption_application).permit(:adopter_id, :pet_id, :status, :application_date)
  end
end
