class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
    @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @user = @prototype.user
    @main_image = @prototype.captured_images.main
    @sub_images = @prototype.captured_images.sub
  end

  def new
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
    @prototype = Prototype.find(params[:id])
    @main_images = @prototype.captured_images.main
    @sub_images = @prototype.captured_images.sub
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototypes_path, notice: "Succeeded to update your prototype"
    else
      redirect_to edit_prototype_path, alert: "Failed to update your prototype"
    end
  end

  def destroy
    if Prototype.destroy(delete_params[:id])
      redirect_to prototypes_path, notice: "Succeeded to delete your prototype"
    else
      redirect_to prototypes_path, alert: "Failed to delete your prototype"
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:name, :catch_copy, :concept, :user_id, captured_images_attributes: [:id, :image, :status])
  end

  def delete_params
    params.permit(:id)
  end
end
