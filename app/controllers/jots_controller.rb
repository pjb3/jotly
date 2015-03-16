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

  def like
    jot = Jot.find(params[:id])
    jot.likes.create!(user_id: current_user.id)
    redirect_to jot_path(jot)
  end

  def unlike
    jot = Jot.find(params[:id])
    jot.likes.where(user_id: current_user.id).delete_all
    redirect_to jot_path(jot)
  end

  def destroy
    jot = Jot.find(params[:id])
    jot.destroy!
    redirect_to jots_path
  end

  private
  def following(user)
    @following ||= Follower.find_by(subscriber_id: current_user.id, user_id: user.id)
  end
  helper_method :following

  def following?(user)
    following(user).present?
  end
  helper_method :following?

  def can_edit?(jot)
    jot.user_id == current_user.id
  end
  helper_method :can_edit?

  def has_not_liked?(jot)
    jot.likes.where(user_id: current_user.id).empty?
  end
  helper_method :has_not_liked?

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
