require "rails_helper"

RSpec.describe 'Road Trip API endpoints' do
  describe "/api/v0/road_trip" do
    it "get recieves user login information and " do
      existing_user = User.create(email: "coolguy@cool.com", password: "cellardoor", password_confirmation: "cellardoor", api_key: "69b815c468ed589d1ec5")

      session_params = {
        "email": "coolguy@cool.com",
        "password": "cellardoor",
      }
    
      post "/api/v0/sessions", params: session_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip_params = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": "69b815c468ed589d1ec5"
      }
    
      post "/api/v0/road_trip", params: road_trip_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      road_trip = JSON.parse(response.body, symbolize_names: true)

      expect(road_trip).to be_a(Hash)
     
      expect(road_trip[:data]).to be_a(Hash)
      expect(road_trip[:data]).to have_key(:id)
      expect(road_trip[:data][:id]).to be(nil)
      expect(road_trip[:data]).to have_key(:type)
      expect(road_trip[:data][:type]).to eq("road_trip")
      expect(road_trip[:data]).to have_key(:attributes)
      expect(road_trip[:data][:attributes]).to be_a(Hash)

      trip = road_trip[:data][:attributes]

      expect(trip).to have_key(:start_city)
      expect(trip).to have_key(:end_city)
      expect(trip).to have_key(:travel_time)
      expect(trip).to have_key(:weather_at_eta)

      expect(trip[:start_city]).to be_a(String)
      expect(trip[:start_city]).to eq("Cincinatti,OH")
      expect(trip[:end_city]).to be_a(String)
      expect(trip[:end_city]).to eq("Chicago,IL")
      expect(trip[:travel_time]).to be_a(String)
      expect(trip[:travel_time]).to eq("04:20:56")

      expect(trip[:weather_at_eta]).to be_a(Array)
      
      t = trip[:weather_at_eta]
      
      t.each do |eta|
        expect(eta).to have_key(:datetime)
        expect(eta).to have_key(:temperature)
        expect(eta).to have_key(:condition)

        expect(eta[:datetime]).to be_a(String)
        expect(eta[:datetime]).to eq("2024-01-17 01:00")
        expect(eta[:temperature]).to be_a(Float)
        expect(eta[:temperature]).to eq(4.0)
        expect(eta[:condition]).to be_a(String)
        expect(eta[:condition]).to eq("Partly cloudy")
      end
    end

   it "returns a 400 error if the api_key doesn't doesn't match an exising user's api_key" do
      existing_user = User.create(email: "coolguy@cool.com", password: "cellardoor", password_confirmation: "cellardoor", api_key: "69b815c468ed589d1ec5")

      session_params = {
        "email": "coolguy@cool.com",
        "password": "cellardoor",
      }
    
      post "/api/v0/sessions", params: session_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip_params = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": "thisisabadapikey"
      }
    
      post "/api/v0/road_trip", params: road_trip_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }

      bad_api = JSON.parse(response.body, symbolize_names: true)
  
      expect(bad_api[:error]).to eq("api_key does not match or is blank.")
      expect(bad_api[:error]).to be_a(String)
      expect(bad_api[:status]).to eq(401)
      expect(bad_api[:status]).to be_a(Integer)

    end

    it "returns a 400 error if the api_key is blank" do
      existing_user = User.create(email: "coolguy@cool.com", password: "cellardoor", password_confirmation: "cellardoor", api_key: "69b815c468ed589d1ec5")

      session_params = {
        "email": "coolguy@cool.com",
        "password": "cellardoor",
      }
    
      post "/api/v0/sessions", params: session_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      road_trip_params = {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": " "
      }
    
      post "/api/v0/road_trip", params: road_trip_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }

      bad_api = JSON.parse(response.body, symbolize_names: true)

      expect(bad_api[:error]).to eq("api_key does not match or is blank.")
      expect(bad_api[:error]).to be_a(String)
      expect(bad_api[:status]).to eq(401)
      expect(bad_api[:status]).to be_a(Integer)


    end
  end
end
