class JotsController < ApplicationController

  def index

    respond_to do |format|

      format.html { @jots = Jot.all  }

      format.json do

        # TODO: use lat/lon params to find jots nearby
        if params[:lat].present? && params[:lon].present?
          @jots = Jot.near([params[:lat], params[:lon]], 25)
        else
          @jots = Jot.all
        end

        data = @jots.map do |jot|
          {
            id: jot.id,
            message: jot.message,
            latitude: jot.latitude.to_f,
            longitude: jot.longitude.to_f
            photo_url: jot.photo.url(:)
          }
        end

        #@jot

        # Above code is equivalent to this:
        # data = []
        # @jots.each do |jot|
        #   data << { id: jot.id, name: jot.message, latitude: jot.latitude, longitude: jot.longitude }
        # end
        # data

        render json: data
      end
    end
  end

  def show
    @jot = Jot.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @jot }
    end
  end

  def new
    @jot = Jot.new
  end

  def create
    @jot = Jot.create(jot_params)

    redirect_to jots_path
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
