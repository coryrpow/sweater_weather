class WeatherService

  def self.get_city_weather(lat, lon)
 
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat}, #{lon}&days=5")
    parse = JSON.parse(response.body, symbolie_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://api.weatherapi.com/v1/')
  end
end