require "rails_helper"

RSpec.describe 'Landing Page API endpoints' do
  describe "/api/v0/weather", :vcr do
    it "get requests all data needed for the landing page" do
      # location = create(:location)
      location = Location.create!(city: "Denver", state: "CO")

      get "/api/v0/forecast?location=#{location.city},#{location.state}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast).to be_a(Hash)
      expect(forecast[:data]).to be_a(Hash)
      expect(forecast[:data][:id]).to be(nil)
      expect(forecast[:data][:type]).to eq("forecast")
      expect(forecast[:data][:attributes]).to be_a(Hash)

      expect(forecast[:data][:attributes]).to have_key(:current_weather)
      expect(forecast[:data][:attributes]).to have_key(:daily_weather)
      expect(forecast[:data][:attributes]).to have_key(:hourly_weather)

      f1 = forecast[:data][:attributes][:current_weather]

      expect(f1.keys.count).to eq(8)
      expect(f1).to have_key(:last_updated)
      expect(f1[:last_updated]).to be_a(String)
      expect(f1).to have_key(:temperature)
      expect(f1[:temperature]).to be_a(Float)
      expect(f1).to have_key(:feels_like)
      expect(f1[:feels_like]).to be_a(Float)
      expect(f1).to have_key(:humidity)
      expect(f1[:humidity]).to be_a(Integer)
      expect(f1).to have_key(:uvi)
      expect(f1[:uvi]).to be_a(Float)
      expect(f1).to have_key(:visibility)
      expect(f1[:visibility]).to be_a(Float)
      expect(f1).to have_key(:condition)
      expect(f1[:condition]).to be_a(String)
      expect(f1).to have_key(:icon)
      expect(f1[:icon]).to be_a(String)

      f2 = forecast[:data][:attributes][:daily_weather]
      
      f2.each do |day|
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
      
      f3 = forecast[:data][:attributes][:hourly_weather]

      f3.each do |hour|
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

    it "does NOT return data that is not needed" do
      location = Location.create!(city: "Denver", state: "CO")

      get "/api/v0/forecast?location=#{location.city},#{location.state}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)

      expect(forecast[:data][:attributes]).to_not have_key(:location)
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:last_updated_eppoc)
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:temp_c)
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:wind_mph)
      expect(forecast[:data][:attributes][:current_weather]).to_not have_key(:wind_kph)

      expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key(:date_epoch)
      expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key(:avgtemp_f)
      expect(forecast[:data][:attributes][:daily_weather].first).to_not have_key(:totalprecip_mm)
     
      expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key(:time_epoch)
      expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key(:pressure_in)
      expect(forecast[:data][:attributes][:hourly_weather].first).to_not have_key(:snow_cm)
    end
  end
end
