class PrototypesController < ApplicationController

  before_action :authenticate_user!, only: :index

  def index
  end

  def show
  end

  def new
  end

end
