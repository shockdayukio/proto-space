class PopularController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).order("like_count DESC").page(params[:page]).per(Prototype::NUMBER_OF_DISPLAYED_PROTOTYPES)
  end
end
