class Adopter::PetsController < ApplicationController

  def index
    @pets = Pet.filter_by_species(params[:species])
                .filter_by_age(params[:age])
                .filter_by_gender(params[:gender])
                .filter_by_temperament(params[:temperament])
                .filter_by_location(params[:location], params[:distance], params[:unit])
    @species_counts = Pet.species_counts
    @age_counts = Pet.age_counts
    @gender_counts = Pet.gender_counts
    @temperament_counts = Pet.temperament_counts
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
