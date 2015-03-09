class HomeController < ApplicationController
  skip_before_filter :require_current_user!

  def show
    if current_user.present?
      redirect_to jots_path
    end
  end
end
