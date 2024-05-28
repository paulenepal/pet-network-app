module ShelterNamespace
  class DashboardController < BaseController
  def index
    @total_pets = current_user.shelter.pets.count
    @adopted_pets = current_user.shelter.pets.adopted.count
    @pending_pets = current_user.shelter.pets.pending.count
  end
 end
end
