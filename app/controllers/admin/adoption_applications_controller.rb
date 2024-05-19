class Admin::AdoptionApplicationsController < Admin::BaseController
  before_action :set_adoption_application, only: [:show]

  def index
    @adoption_applications = AdoptionApplication.all
  end

  def show
  end

  private

  def set_adoption_application
    @adoption_application = AdoptionApplication.find(params[:id])
  end
end
