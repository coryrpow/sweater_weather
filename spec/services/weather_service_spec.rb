require 'rails_helper'

RSpec.describe WeatherService do
  context 'class methods' do
    context '#get_city_weather' do
      it 'returns a hash of weather data for specific lat and lon coordinates' do
        weather = WeatherService.get_city_weather(38.26375, -104.61252)
        # require 'pry';binding.pry
        expect(weather).to be_a(Hash)

        expect(weather).to have_key(:current_weather)
        expect(weather).to have_key(:daily_weather)
        expect(weather).to have_key(:hourly_weather)

        w1 = weather[:current_weather]

    
        expect(w1.keys.count).to eq(8)
        expect(w1).to have_key(:last_updated)
        expect(w1[:last_updated]).to be_a(String)
        expect(w1).to have_key(:temperature)
        expect(w1[:temperature]).to be_a(Float)
        expect(w1).to have_key(:feels_like)
        expect(w1[:feels_like]).to be_a(Float)
        expect(w1).to have_key(:humidity)
        expect(w1[:humidity]).to be_a(Integer)
        expect(w1).to have_key(:uvi)
        expect(w1[:uvi]).to be_a(Float)
        expect(w1).to have_key(:visibility)
        expect(w1[:visibility]).to be_a(Float)
        expect(w1).to have_key(:condition)
        expect(w1[:condition]).to be_a(String)
        expect(w1).to have_key(:icon)
        expect(w1[:icon]).to be_a(String)

        w2 = weather[:daily_weather]
        
        w2.each do |day|
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
    
        w3 = weather[:hourly_weather]

        w3.each do |hour|
          # require 'pry';binding.pry
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

    context "get_munchie_weather" do
      it "returns a hash of only needed data for a restaurant" do
        weather = WeatherService.get_munchie_weather(38.26375, -104.61252)

        expect(weather).to be_a(Hash)
        expect(weather.keys.count).to eq(2)
        expect(weather[:temperature]).to be_a(Float)
        # expect(weather[:temperature]).to eq(3.9)
        expect(weather[:summary]).to be_a(String)
        # expect(weather[:summary]).to eq("Overcast")
      end
    end
  end
end
