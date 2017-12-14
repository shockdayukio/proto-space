class Prototypes::NewestController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).newest_order.page(params[:page]).per(Prototype::NUMBER_OF_DISPLAYED_PROTOTYPES)
  end
end
