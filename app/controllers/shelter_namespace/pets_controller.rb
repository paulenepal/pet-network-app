module ShelterNamespace
  class PetsController < BaseController
    before_action :set_pet, only: [:show, :edit, :update, :destroy, :update_status]

  def index
    @pets = current_user.shelter.pets

    if params[:location].present?
      distance = params[:distance].present? ? params[:distance].to_f : 15
      unit = params[:unit] == 'km' ? :km : :mi  # allows user to select if km or miles
      @pets = @pets.near(params[:location], distance, units: unit)
    end
  end


  def show
    @pet_comments = @pet.pet_comments.includes(:user)
    @pet_comment = PetComment.new
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = current_user.shelter.pets.build(pet_params)
    if @pet.save
      flash[:notice] = "Pet added successfully"
      redirect_to shelter_namespace_pets_path
    else
      render :new
    end
  end



  def edit
  end

  def update
    if @pet.update(pet_params)
      flash[:notice] = "Pet updated successfully"
      redirect_to shelter_namespace_pet_path(@pet)
    else
      render :edit
    end
  end


  def destroy
    @pet.destroy
    flash[:notice] = "Pet removed successfully"
    redirect_to shelter_namespace_pets_path
  end

  def update_status
    if @pet.update(adoption_status: params[:adoption_status])
      flash[:notice] = "Pet status updated successfully"
    else
      flash[:alert] = "Unable to update status"
    end
    redirect_to shelter_namespace_pet_path(@pet)
  end


  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :age, :size, :gender, :temperament, :description, :photo_url, :location, :adoption_status)
   end
  end
end
