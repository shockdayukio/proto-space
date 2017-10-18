class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    sign_in(@user, bypass: true)
    redirect_to(prototypes_path)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :occupation, :profile, :works)
  end
end
