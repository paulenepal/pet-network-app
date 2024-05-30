class Adopter::PetsController < ApplicationController

  def index
    @pets = Pet.all

    if params[:location].present?
      distance = params[:distance].present? ? params[:distance].to_f : 15
      unit = params[:unit] == 'km' ? :km : :mi  # allows user to select if km or miles
      @pets = @pets.near(params[:location], distance, units: unit)
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @pet_comment = PetComment.new
  end

  def create
    pet = Pet.find(params[:pet_id])
    if current_user.favorites.include?(pet)
      current_user.favorites.delete(pet)
      flash[:notice] = "Removed from favorites"
    else
      current_user.favorites << pet
      flash[:notice] = "Added to favorites"
    end
    redirect_to pets_path
  end

end
