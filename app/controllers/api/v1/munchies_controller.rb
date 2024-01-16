class Api::V1::MunchiesController < ApplicationController
  def show
    munchies = MunchiesFacade.get_munchie(params[:destination], params[:food])
    render json: MunchieSerializer.new(munchies)
  end
end