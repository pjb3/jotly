class JotController < ApplicationController

  def new
    @jot = Jot.new
  end
end
