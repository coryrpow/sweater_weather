class Forecast
  attr_reader :id,
              :current_weather,
              :daily_weather,
              :hourly_weather

  def initialize(weather_response)
    @id = nil
    @current_weather = weather_response
    @daily_weather = weather_response
    @hourly_weather = weather_response


  end
end