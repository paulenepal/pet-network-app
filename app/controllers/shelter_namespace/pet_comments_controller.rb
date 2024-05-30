module ShelterNamespace
    class PetCommentsController < BaseController
      before_action :set_pet
  
      def create
        @pet_comment = @pet.pet_comments.build(pet_comment_params)
        @pet_comment.user = current_user
  
        if @pet_comment.save
          flash[:notice] = "Comment added successfully"
          redirect_to shelter_namespace_pet_path(@pet)
        else
          flash[:alert] = "Unable to add comment"
          render 'pets/show'
        end
      end
  
      private
  
      def set_pet
        @pet = Pet.find(params[:pet_id])
      end
  
      def pet_comment_params
        params.require(:pet_comment).permit(:comment_text)
      end
    end
  end
  