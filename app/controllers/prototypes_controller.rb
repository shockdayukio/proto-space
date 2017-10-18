class PrototypesController < ApplicationController

before_action :set_user, only: [:index, :show]

  def index
  end

  def show
  end

  def new
  end

  private
  def set_user
    @user = current_user
  end
end
