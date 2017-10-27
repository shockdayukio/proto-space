class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: :new

  def index
  end

  def show
  end

  def new
    @prototype = Prototype.new
  end

  def create
    if Prototype.create(prototype_params)
      redirect_to prototypes_path, notice: "Succeeded to publish your prototype"
    else
      redirect_to prototypes_path, alert: "Failed to publish your prototype"
    end
  end

  private
  def prototype_params
    params.require(:prototype).permit(:name, :image, :catch_copy, :concept, :user_id)
  end
end
