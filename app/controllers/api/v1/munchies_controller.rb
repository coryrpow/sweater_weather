class Api::V1::MunchiesController < ApplicationController
  def show
    munchies = MunchiesFacade.get_munchie(params[:destination], params[:food])
    require 'pry';binding.pry
    # render json: MunchieSerializer.new(munchies)

  end
end