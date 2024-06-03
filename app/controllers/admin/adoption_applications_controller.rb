class Admin::AdoptionApplicationsController < Admin::BaseController
  before_action :set_adoption_application, only: [:show]

  def index
    @adoption_applications = AdoptionApplication.includes(:adopter, :pet).all
    @adoption_applications.each do |application|
      Rails.logger.info("AdoptionApplication ID: #{application.id}, Adopter ID: #{application.adopter_id}, Adopter: #{application.adopter.inspect}")
      if application.adopter
        application.adopter.reload
        Rails.logger.info("User ID: #{application.adopter.id}, User: #{application.adopter.inspect}")
      else
        Rails.logger.info("Adopter is nil for AdoptionApplication ID: #{application.id}")
      end
    end
  end

  def show
    Rails.logger.info("AdoptionApplication ID: #{@adoption_application.id}, Adopter: #{@adoption_application.adopter.inspect}, Pet: #{@adoption_application.pet.inspect}")
    if @adoption_application.adopter
      @adoption_application.adopter.reload
      Rails.logger.info("User ID: #{@adoption_application.adopter.id}, User: #{@adoption_application.adopter.inspect}")
    else
      Rails.logger.info("Adopter is nil for AdoptionApplication ID: #{@adoption_application.id}")
    end
  end

  private

  def set_adoption_application
    @adoption_application = AdoptionApplication.find(params[:id])
  end
end
