class MunchiesFacade
  def self.get_munchie(location, food_type)
    mapquest_response = MapquestService.get_location(location)
    restaurant_response = YelpService.get_restaurant(food_type, mapquest_response[:lat], mapquest_response[:lng] )
    weather_response = WeatherService.get_munchie_weather(mapquest_response[:lat], mapquest_response[:lng])
    Munchie.new(location, restaurant_response, weather_response)
   
  end

end