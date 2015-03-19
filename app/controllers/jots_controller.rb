class JotsController < ApplicationController

  def show
    @jot = Jot.find(params[:id])
  end

  def new
    @jot = Jot.new
  end

  def create
    @jot = Jot.create(jot_params)

    redirect_to jots_path
  end

  def index
    @jots = Jot.all
  end

  def edit
    @jot = Jot.find(params[:id])
  end

  def update
    jot = Jot.find(params[:id])
    jot.update(jot_params)

    redirect_to jots_path
  end

  def destroy
    jot = Jot.find(params[:id])
    jot.destroy

    redirect_to jots_path
  end

  def like
    jot = Jot.find(params[:id])
    jot.likes.create(user_id: current_user.id)
    redirect_to jot_path(jot)
  end

  def unlike
    jot = Jot.find(params[:id])
    jot.likes.where(user_id: current_user.id).delete_all
    redirect_to jot_path(jot)
  end

  def has_not_liked?(jot)
    jot.likes.where(user_id: current_user.id).empty?
  end
  helper_method :has_not_liked?

  def jot_author_or_other_person(jot)
    if jot.user_id == current_user.try(:id)
      'you'
    else
      jot.user.name
    end
  end
  helper_method :jot_author_or_other_person

  def likes_list(jot)
    jot.likes
  end
  helper_method :likes_list

  private
  def jot_params
    params.require(:jot).permit(
      :message, :photo, :latitude, :longitude).merge(
      user: current_user)
  end


end
