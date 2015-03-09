class UserController < ApplicationController
  skip_before_filter :require_current_user!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user = User.create!(user_params)
    session[:current_user_id] = user.id
    redirect_to jots_path
  end

  def show; end

  def edit; end

  def update
    current_user.update!(user_params)
    redirect_to jots_path
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end
end
