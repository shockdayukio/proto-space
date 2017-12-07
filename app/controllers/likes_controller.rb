class LikesController < ApplicationController

  def create
    current_user.likes.create(like_params)
  end

  def destroy
    Like.destroy
  end

  private

  def like_params
    params.permit(:prototype_id)
  end
end
