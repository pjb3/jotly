class SessionController < ApplicationController
  skip_before_filter :require_current_user!

  def new; end

  def create
    user = User.find_by(email: params[:email])

    # TODO: verify password
    if user.present?
      session[:current_user_id] = user.id
      redirect_to jots_path, notice: "You're signed in"
    else
      flash[:warning] = "No user with that name"
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
