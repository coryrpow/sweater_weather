class Munchie
  attr_reader :id,
              :destination_city,
              :forecast,
              :restaurant

  def initialize(location, restaurant_response, weather_response)
    # require 'pry';binding.pry
    @id = nil
    @destination_city = location
    @forecast = restaurant_response
    @restaurant = weather_response
  end
end