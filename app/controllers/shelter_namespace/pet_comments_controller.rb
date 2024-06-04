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
        @pet_comments = @pet.pet_comments
        flash.now[:alert] = "Unable to add comment"
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace("pet_comments_section", partial: "shelter_namespace/pets/comments", locals: { pet: @pet, pet_comments: @pet_comments }) }
          format.html { render 'shelter_namespace/pets/show' }
        end
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
