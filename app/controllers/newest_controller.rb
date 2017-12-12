class NewestController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).order("created_at DESC").page(params[:page]).per(Prototype::
  NUMBER_OF_DISPLAYED_PROTOTYPES)
  end
end
