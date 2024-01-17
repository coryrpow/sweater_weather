require 'rails_helper'

RSpec.describe Forecast do
  describe 'initialize' do
    it 'creates a forecast object', :vcr do
      mapquest_response = MapquestService.get_location("Denver,CO")
      weather_response = WeatherService.get_city_weather(mapquest_response[:lat], mapquest_response[:lng])
      forecast = Forecast.new(weather_response)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.current_weather.keys.count).to eq(8)
      expect(forecast.current_weather).to have_key(:last_updated)
      expect(forecast.current_weather[:last_updated]).to be_a(String)
      expect(forecast.current_weather).to have_key(:temperature)
      expect(forecast.current_weather[:temperature]).to be_a(Float)
      expect(forecast.current_weather).to have_key(:feels_like)
      expect(forecast.current_weather[:feels_like]).to be_a(Float)
      expect(forecast.current_weather).to have_key(:humidity)
      expect(forecast.current_weather[:humidity]).to be_a(Integer)
      expect(forecast.current_weather).to have_key(:uvi)
      expect(forecast.current_weather[:uvi]).to be_a(Float)
      expect(forecast.current_weather).to have_key(:visibility)
      expect(forecast.current_weather[:visibility]).to be_a(Float)
      expect(forecast.current_weather).to have_key(:condition)
      expect(forecast.current_weather[:condition]).to be_a(String)
      expect(forecast.current_weather).to have_key(:icon)
      expect(forecast.current_weather[:icon]).to be_a(String)

      expect(forecast.daily_weather).to be_a(Array)
      # five day forecast
      expect(forecast.daily_weather.count).to eq(5)

      forecast.daily_weather.each do |day|
        expect(day).to be_a(Hash)
        expect(day.keys.count).to eq(7)
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a(String)
        
        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a(String)
        
        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a(String)
        
        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a(Float)
        
        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a(Float)
        
        expect(day).to have_key(:condition)
        expect(day[:condition]).to be_a(String)
        
        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a(String)
      end

      expect(forecast.hourly_weather).to be_a(Array)
      forecast.hourly_weather.each do |hour|
        expect(hour).to be_a(Hash)
        expect(hour.keys.count).to eq(4)

        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a(String)
      
        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_a(Float)
        
        expect(hour).to have_key(:conditions)
        expect(hour[:conditions]).to be_a(String)
        
        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_a(String)
      end
    end
  end
end