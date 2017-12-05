class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]

  def show
    prototypes = @user.prototypes
    @prototypes_count = prototypes.length
    @prototypes = prototypes.page(params[:page]).per(8)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      sign_in(@user, bypass: true)
      redirect_to prototypes_path, notice: "Succeeded to update your information"
    else
      redirect_to edit_user_path, alert: "Failed to update your information"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :occupation, :profile, :works)
  end
end
