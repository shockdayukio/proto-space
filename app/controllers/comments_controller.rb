class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    @prototype = Prototype.find(comment_params[:prototype_id])
    @comment = current_user.comments.create(comment_params)
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(params.permit(:prototype_id))
  end
end
