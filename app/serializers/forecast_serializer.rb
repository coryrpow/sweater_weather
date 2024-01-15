class ForecastSerializer
include JSONAPI::Serializer

  # def self.forecast_response(forecast)
  #   require 'pry';binding.pry
  #   {
  #     "data": {
  #       "id": nil,
  #       "type": "forecast",
  #       "attributes": {
  #         "current_weather": forecast_current(forecast["current"]),
  #         "daily_weather": forecast_daily(forecast["forecast"]["forecastday"]),
  #         "hourly_weather": forecast_hourly(forecast["forecast"]["forecastday"].first["hour"])
  #       }
  #     }
  #   }

  # end

  # def self.forecast_current(current)
  #   {
  #     last_updated: current["last updated"],
  #     temperature: current["temp_f"]
  #   }

  # end

  # def self.forecast_daily(daily)


  # end

  # def self.forecast_hourly(hourly)


  # end
end