class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @User = User.create(user_params)

    redirect_to jots_path
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end



end
