class CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create

  def create
    Comment.create(text: comment_params[:text], prototype_id: comment_params[:prototype], user_id: current_user.id)
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :prototype)
  end
end
