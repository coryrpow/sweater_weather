require 'rails_helper'

RSpec.describe Munchie do
  describe 'initialize' do
    it 'creates a forecast object' do
      mapquest_response = MapquestService.get_location("Pueblo,CO")
      restaurant_response = YelpService.get_restaurant("italian", mapquest_response[:lat], mapquest_response[:lng] )
      weather_response = WeatherService.get_munchie_weather(mapquest_response[:lat], mapquest_response[:lng])
      munchie = Munchie.new("Pueblo,CO", restaurant_response, weather_response)

      expect(munchie).to be_a(Munchie)
      # require 'pry';binding.pry
      expect(munchie.destination_city).to eq("Pueblo,CO")
      expect(munchie.destination_city).to be_a(String)
      expect(munchie.id).to be(nil)
      expect(munchie.forecast).to be_a(Hash)
      expect(munchie.forecast).to have_key(:temperature)
      expect(munchie.forecast[:temperature]).to be_a(Float)
      # expect(munchie.forecast[:temperature]).to eq(5.0)
      expect(munchie.forecast).to have_key(:summary)
      expect(munchie.forecast[:summary]).to be_a(String)
      # expect(munchie.forecast[:summary]).to eq("Overcast")

      expect(munchie.restaurant).to have_key(:name)
      expect(munchie.restaurant).to have_key(:address)
      expect(munchie.restaurant).to have_key(:rating)
      expect(munchie.restaurant).to have_key(:reviews)

      expect(munchie.restaurant).to have_key(:name)
      expect(munchie.restaurant[:name]).to be_a(String)
      # expect(munchie.restaurant[:name]).to eq("La Forchetta Da Massi")
      expect(munchie.restaurant).to have_key(:address)
      expect(munchie.restaurant[:address]).to be_a(String)
      # expect(munchie.restaurant[:address]).to eq("126 S Union Ave, Pueblo, CO 81003")
      expect(munchie.restaurant).to have_key(:rating)
      expect(munchie.restaurant[:rating]).to be_a(Float)
      # expect(munchie.restaurant[:rating]).to eq(4.5)
      expect(munchie.restaurant).to have_key(:reviews)
      expect(munchie.restaurant[:reviews]).to be_a(Integer)
      # expect(munchie.restaurant[:reviews]).to eq(230)
    end
  end
end