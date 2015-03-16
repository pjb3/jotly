class FollowersController < ApplicationController
  before_filter :ensure_own_follower!, only: :destroy

  def create
    Follower.create!(user_id: params[:user_id], subscriber_id: current_user.id)
    redirect_to :jots
  end

  def destroy
    @follower.destroy!
    redirect_to :jots
  end

  private
  def ensure_own_follower!
    @follower = Follower.find(params[:id])
    @follower.subscriber_id == current_user.id
  end
end
