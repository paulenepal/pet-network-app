# app/controllers/pets_controller.rb
class PetsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_shelter, only: [:new, :create, :edit, :update]

  # ... other actions
  def new
    @pet = @shelter.pets.build
  end

  def create
    @pet = @shelter.pets.build(pet_params)
    if @pet.save
      redirect_to shelter_pet_path(@shelter, @pet), notice: "Pet created successfully."
    else
      render :new
    end
  end

  # ... other actions

  private

  def set_shelter
    @shelter = current_user.shelter
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :age, :size, :gender, :temperament, :description, :photo_url, :adoption_status, :location)
  end
end
