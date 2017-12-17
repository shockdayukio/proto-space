class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user, :tags).page(params[:page]).per(Prototype::NUMBER_OF_DISPLAYED_PROTOTYPES)
  end

  def show
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @placeholders = [ "Web design", "UI", "Application"]
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = current_user.prototypes.new(prototype_params)

    if @prototype.save
      redirect_to prototypes_path, notice: "Succeeded to publish your prototype"
    else
      redirect_to new_prototype_path, alert: "Failed to publish your prototype"
    end
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototypes_path, notice: "Succeeded to update your prototype"
    else
      redirect_to edit_prototype_path, alert: "Failed to update your prototype"
    end
  end

  def destroy
    unless @prototype.created_by?(current_user)
      redirect_to prototypes_path, alert: "Cannot delete other's prototype"
    end

    if @prototype.destroy
      redirect_to prototypes_path, notice: "Succeeded to delete your prototype"
    else
      redirect_to prototypes_path, alert: "Failed to delete your prototype"
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:name, :catch_copy, :concept, :user_id, tag_list: [], captured_images_attributes: [:id, :image, :status])
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
end
