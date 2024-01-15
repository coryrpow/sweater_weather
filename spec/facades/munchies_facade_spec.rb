require 'rails_helper'

RSpec.describe MunchiesFacade do
  describe '#facade methods' do
    it 'can get data for a city restaurant that has the yelp rating and reviews as well as the forecast for the city' do
      # VCR.use_cassette('search_for_terminator', record: :new_episodes) do
     
      munchie = MunchiesFacade.get_munchie("pueblo,co", "italian")

      expect(munchie).to be_a(Munchie)
      # expect(munchie.keys.count).to eq(3)
      # require 'pry';binding.pry
      
      expect(munchie.destination_city).to eq("pueblo,co")
      expect(munchie.forecast).to be_a(Hash)
      expect(munchie.restaurant).to be_a(Hash)

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
      
      # expect(munchie.current_weather.keys.count).to eq(8)
      # expect(munchie.current_weather).to have_key(:last_updated)
      # expect(munchie.current_weather[:last_updated]).to be_a(String)
      # expect(munchie.current_weather).to have_key(:temperature)
      # expect(munchie.current_weather[:temperature]).to be_a(Float)
      # expect(munchie.current_weather).to have_key(:feels_like)
      # expect(munchie.current_weather[:feels_like]).to be_a(Float)
      # expect(munchie.current_weather).to have_key(:humidity)
      # expect(munchie.current_weather[:humidity]).to be_a(Integer)
      
    end
  end
end