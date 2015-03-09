class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_current_user!

  def require_current_user!
    if current_user.blank?
      redirect_to new_session_path, notice: 'Please sign-in or sign-up!'
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end
  helper_method :current_user
end
