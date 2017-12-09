class LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    current_user.likes.create(prototype_id: like_params[:id])
    set_prototype
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    current_user.likes.find_by(prototype_id: like_params[:id]).destroy
    set_prototype
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def like_params
    params.permit(:id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
