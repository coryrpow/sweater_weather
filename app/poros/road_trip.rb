class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(origin, destination, mapquest_road_trip, weather_response)
    require 'pry';binding.pry
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = mapquest_road_trip[:formattedTime]
    @weather_at_eta = weather_response

  end
end