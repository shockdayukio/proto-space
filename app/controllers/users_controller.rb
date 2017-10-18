class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit]

  def show
  end

  def edit
  end

  def update
    User.update(user_params)
    redirect_to(user_path)
  end

  private
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :occupation, :profile, :works)
  end
end
