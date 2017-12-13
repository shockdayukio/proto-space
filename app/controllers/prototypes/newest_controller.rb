class Prototypes::NewestController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).created_at.page(params[:page]).per(Prototype::NUMBER_OF_DISPLAYED_PROTOTYPES)
  end
end
