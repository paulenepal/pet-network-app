class Admin::AdoptersController < Admin::BaseController
    before_action :set_adopter, only: [:edit, :update]
  
    def edit
    end
  
    def update
      if @adopter.update(adopter_params)
        redirect_to admin_user_path(@adopter.user), notice: 'Adopter details were successfully updated.'
      else
        render :edit
      end
    end
  
    private
  
    def set_adopter
      @adopter = Adopter.find(params[:id])
    end
  
    def adopter_params
      params.require(:adopter).permit(:first_name, :last_name, :preference)
    end
  end
  