class Adopter::FavoritesController < Adopter::BaseController
  
  def index
    @favorites = current_user.favorites.includes(:pet)
  end

  def create
    pet = Pet.find(params[:pet_id])
    current_user.favorites.create(pet: pet)
    redirect_to adopter_pets_path, notice: "Added to favorites"
  end

  def destroy
    favorite = current_user.favorites.find_by(pet_id: params[:pet_id])
    if favorite
      favorite.destroy
      notice_message = "Removed from favorites"
    else
      notice_message = "Favorite not found"
    end
    redirect_path = params[:redirect_to] == 'favorites' ? adopter_favorites_path : adopter_pets_path
    redirect_to redirect_path, notice: notice_message
  end
  
end
