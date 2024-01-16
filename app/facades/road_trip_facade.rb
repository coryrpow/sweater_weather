class RoadTripFacade
  def self.get_road_trip(origin, destination)
    mapquest_response = MapquestService.get_location(destination)
    mapquest_road_trip = MapquestService.get_trip(origin, destination)
    weather_response = WeatherService.get_destination_weather(mapquest_response[:lat], mapquest_response[:lng], mapquest_road_trip)
    RoadTrip.new(origin, destination, mapquest_road_trip, weather_response)

  end
end