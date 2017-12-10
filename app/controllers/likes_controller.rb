class LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    current_user.likes.create(prototype_id: prototype_params[:id])
    set_prototype
  end

  def destroy
    current_user.likes.find_by(prototype_id: prototype_params[:id]).destroy
    set_prototype
  end

  private

  def prototype_params
    params.permit(:id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
