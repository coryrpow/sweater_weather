require 'rails_helper'

RSpec.describe MunchiesFacade do
  describe '#facade methods' do
    it 'can get data for a city restaurant that has the yelp rating and reviews as well as the forecast for the city' do
      # VCR.use_cassette('search_for_terminator', record: :new_episodes) do
     
      munchie = MunchiesFacade.get_munchie("pueblo,co", "italian")

      expect(munchie).to be_a(Munchie)
      expect(munchie.keys.count).to eq(3)
      
      expect(munchie).to have_key(:destination)
      expect(munchie).to have_key(:forecast)
      expect(munchie).to have_key(:restaurant
      )
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