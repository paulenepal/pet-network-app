class Adopter::CommentsController < ApplicationController
  before_action :set_pet

  def create
    @pet_comment = @pet.pet_comments.build(comment_params)
    @pet_comment.user_id = current_user.id
    if @pet_comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to adopter_pet_path(@pet), notice: 'Comment was successfully created.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_comment", partial: "adopter/pets/comments", locals: { pet: @pet, pet_comment: @pet_comment }) }
        format.html { redirect_to adopter_pet_path(@pet), alert: 'Comment could not be created.' }
      end
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
