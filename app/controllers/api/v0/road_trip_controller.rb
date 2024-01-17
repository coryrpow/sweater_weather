class Api::V0::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])

    if user
      road_trip = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: bad_api(user), status: :unauthorized
    end

  end




  private

  def road_trip_response(road_trip)
      {
        data: {
            id: "null",
            type: "road_road_trip",
            attributes: {
                start_city: road_trip.start_city,
                end_city: road_trip.end_city,
                travel_time: road_trip.travel_time,
                weather_at_eta: {
                    datetime: road_trip.datetime0,
                    temperature: road_trip.temperature,
                    condition: road_trip.condition
                }
            }
        }
    }
  end

  def bad_api(user)
    {
      error: "api_key does not match or is blank.",
      status: 401
    }
  end

  # def empty_api(user)
  #   {
  #     error: "Must provide api_key.",
  #     status: 401
  #   }
  # end
end