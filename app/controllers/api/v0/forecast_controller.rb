class Api::V0::ForecastController < ApplicationController
  def show
    require 'pry';binding.pry
    forecast = ForecastFacade.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end

end