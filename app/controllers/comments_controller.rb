class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @prototype = Prototype.find(comment_params[:prototype_id])
    @comment = Comment.create(text: comment_params[:text], prototype_id: comment_params[:prototype_id], user_id: current_user.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :prototype_id)
  end
end
