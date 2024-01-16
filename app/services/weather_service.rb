class WeatherService
  def self.get_munchie_weather(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat}, #{lon}&days=5")
    parse_m = JSON.parse(response.body, symbolize_names: true)
    format_munchie(parse_m)
  end

  def self.format_munchie(parse_m)
    current = parse_m[:current]
    nothing_more = {
        temperature: current[:temp_f],
        summary: current[:condition][:text]
        }
  end

  def self.get_destination_weather(lat, lon, time)
    
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat}, #{lon}&days=5")
    first_parse = JSON.parse(response.body, symbolize_names: true)
    parse = first_parse[:forecast][:forecastday]
    eta_parse(parse, time)
  end
  
  def self.eta_parse(parse, time)
    t = time[:time].to_i
    travel_time_diff = (Date.today - Time.at(t).to_date).to_i
    require 'pry';binding.pry
    #   parse.each do |day|
    #    day[:hour].each do |hour|
    #      time_diff = (Time.at(hour[:time_epoch]).to_date - Date.today).to_i
    #      if time_diff == travel_time_diff
    #        puts "match found!"
    #      end  
    #    end  
    #  end  


  end

  def self.get_city_weather(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat}, #{lon}&days=5")
    parse = JSON.parse(response.body, symbolize_names: true)
    format_parse(parse)
  end
  
  def self.format_parse(parse)
    current = parse[:current]
    daily = parse[:forecast][:forecastday]
    hourly = parse[:forecast][:forecastday].first[:hour]
    nothing_more = {
      current_weather: {
        last_updated: current[:last_updated],
        temperature: current[:temp_f],
        feels_like: current[:feelslike_f],
        humidity: current[:humidity],
        uvi: current[:uv],
        visibility: current[:vis_miles],
        condition: current[:condition][:text],
        icon: current[:condition][:icon]
      },
      daily_weather: daily.map do |day|
        {
          date: day[:date],
          sunrise: day[:astro][:sunrise],
          sunset: day[:astro][:sunset],
          max_temp: day[:day][:maxtemp_f],
          min_temp: day[:day][:mintemp_f],
          condition: day[:day][:condition][:text],
          icon: day[:day][:condition][:icon]
        }
      end,
      hourly_weather: hourly.map do |hour|
        {
          time: hour[:time],
          temperature: hour[:temp_f],
          conditions: hour[:condition][:text],
          icon: hour[:condition][:icon]
        }
      end
    }
  end
  
private

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end
end