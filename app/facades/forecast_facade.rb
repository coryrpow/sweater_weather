class ForecastFacade
  def self.get_forecast(location)
    mapquest_response = MapquestService.get_location(location)
    weather_response = WeatherService.get_city_weather(mapquest_response[:lat], mapquest_response[:lng])
    #need a poro to hold the forecast data next
    # require 'pry';binding.pry
  end
end