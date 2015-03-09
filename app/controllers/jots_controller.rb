class JotsController < ApplicationController
  def index
    @jots = Jot.all
  end

  def new
    @jot = Jot.new
  end

  def create
    jot = Jot.create!(jot_params)
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
  def jot_params
    params.require(:jot).permit(:content)
  end
end
