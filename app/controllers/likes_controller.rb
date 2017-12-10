class LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_prototype, only: [:create, :destroy]

  def create
    @prototype.likes.create(user_id: current_user.id)
  end

  def destroy
    like = @prototype.likes.find_by(user_id: current_user.id)
    like.destroy if like.present?
  end

  private
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
