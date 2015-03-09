class JotsController < ApplicationController

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


  def jot_params
    params.require(:jot).permit(:message)
  end


end
