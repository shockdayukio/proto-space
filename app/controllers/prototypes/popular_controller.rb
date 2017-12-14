class Prototypes::PopularController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user).from_highest_count.page(params[:page]).per(Prototype::NUMBER_OF_DISPLAYED_PROTOTYPES)
  end
end
