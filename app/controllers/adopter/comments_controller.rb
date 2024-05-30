class Adopter::CommentsController < ApplicationController
  before_action :set_pet

  def create
    @pet_comment = @pet.pet_comments.build(comment_params)
    @pet_comment.user_id = current_user.id
    if @pet_comment.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("pet_comments", partial: "comment", locals: { pet_comment: @pet_comment }) }
        format.html { redirect_to adopter_pet_path(@pet), notice: "Comment added successfully." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.alert("Comment can't be blank.") }
        format.html { redirect_to adopter_pet_path(@pet), alert: "Comment can't be blank." }
      end
    end
  end
  
  def destroy
    @comment = @pet.pet_comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove("comment_#{pet_comment.id}")
      end
      format.html { redirect_to adopter_pet_path(@pet) }
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
