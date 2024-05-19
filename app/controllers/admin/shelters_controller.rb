class Admin::SheltersController < Admin::BaseController
    before_action :set_shelter, only: [:edit, :update]
  
    def edit
    end
  
    def update
      if @shelter.update(shelter_params)
        redirect_to admin_user_path(@shelter.user), notice: 'Shelter details were successfully updated.'
      else
        render :edit
      end
    end
  
    private
  
    def set_shelter
      @shelter = Shelter.find(params[:id])
    end
  
    def shelter_params
      params.require(:shelter).permit(:name, :address, :phone_number, :website, :description)
    end
  end
  