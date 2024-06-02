module ShelterNamespace
  class PetsController < BaseController
    before_action :set_pet, only: [:show, :edit, :update, :destroy, :update_status, :delete_photo]

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
      @pet = current_user.shelter.pets.build(pet_params.except(:photo_urls))
      if @pet.save
        attach_photos if params[:pet][:photo_urls].present?
        flash[:notice] = "Pet added successfully"
        redirect_to shelter_namespace_pets_path
      else
        render :new
      end
    end  

    def edit
    end

    def update
      if @pet.update(pet_params.except(:photo_urls))
        attach_photos if params[:pet][:photo_urls].present?
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

    def uploads
      uploaded_file = params[:file]
      blob = ActiveStorage::Blob.create_and_upload!(
        io: uploaded_file,
        filename: uploaded_file.original_filename,
        content_type: uploaded_file.content_type
      )
      render json: { file_url: blob.signed_id }
    end

    def delete_photo
      photo = @pet.photos.find(params[:photo_id])
      photo.purge
      flash.now[:notice] = "Photo deleted successfully"
      
      respond_to do |format|
        format.html { redirect_to shelter_namespace_pet_path(@pet) }
        format.js
      end
    end  

    private

    def set_pet
      @pet = Pet.find(params[:id])
    end

    def pet_params
      params.require(:pet).permit(:name, :species, :breed, :age, :size, :gender, :temperament, :description, :location, :adoption_status, photo_urls: [])
    end

    def attach_photos
      params[:pet][:photo_urls].each do |signed_id|
        blob = ActiveStorage::Blob.find_signed(signed_id)
        @pet.photos.attach(blob)
      end
    end
  end
end
