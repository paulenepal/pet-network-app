class Adopter::CommentsController < Adopter::BaseController
  before_action :set_pet

  def create
    @pet_comment = @pet.pet_comments.build(comment_params)
    @pet_comment.user = current_user

    if @pet_comment.save
      flash[:notice] = "Comment was successfully added."
      redirect_to adopter_pet_path(@pet)
    else
      flash[:alert] = "Unable to add comment"
      render 'adopter/pets/show'
    end
  end
  
  private

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end

  def comment_params
    params.require(:pet_comment).permit(:comment_text)
  end

end
