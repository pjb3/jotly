class JotsController < ApplicationController
  before_filter :require_can_edit!, only: [:edit, :update, :destroy]

  def index
    @jots = Jot.order('created_at desc')
  end

  def new
    @jot = Jot.new
  end

  def create
    jot = Jot.create!(new_jot_params)
    redirect_to jots_path
  end

  def show
    @jot = Jot.find(params[:id])
  end

  def edit
    @jot = Jot.find(params[:id])
  end

  def update
    Jot.find(params[:id]).update!(jot_params)
    redirect_to jots_path
  end

  def destroy
    jot = Jot.find(params[:id])
    jot.destroy!
    redirect_to jots_path
  end

  private
  def can_edit?(jot)
    jot.user_id == current_user.id
  end
  helper_method :can_edit?

  def require_can_edit!
    unless can_edit?(Jot.find(params[:id]))
      redirect_to jot_path(jot), notice: "Can't edit that jot"
    end
  end

  def new_jot_params
    jot_params.merge(user: current_user)
  end

  def jot_params
    params.require(:jot).permit(:content)
  end
end
