class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:current_user_id] = user.id
      redirect_to jots_path
    else
      redirect_to new_user_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end



end
