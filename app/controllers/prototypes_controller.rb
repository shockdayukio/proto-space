class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    if current_user.prototypes.create(prototype_params)
      redirect_to prototypes_path, notice: "Succeeded to publish your prototype"
    else
      redirect_to prototypes_path, alert: "Failed to publish your prototype"
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:name, :catch_copy, :concept, :user_id, captured_images_attributes: [:image, :status])
  end
end
