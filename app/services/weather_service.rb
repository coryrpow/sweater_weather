class WeatherService

  def self.get_city_weather(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat}, #{lon}&days=5")
    parse = JSON.parse(response.body, symbolize_names: true)
    format_parse(parse)
  end
  
  def self.format_parse(parse)
    require 'pry';binding.pry
    current = parse[:current]
    daily = parse[:forecast][:forecastday]
    hourly = parse[:forecast][:forecastday].first[:hour]
    nothing_more = {
      current_weather:
    }
  end
  
private

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end
end