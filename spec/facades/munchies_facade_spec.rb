require 'rails_helper'

RSpec.describe MunchiesFacade do
  describe '#facade methods' do
    it 'can get data for a city restaurant that has the yelp rating and reviews as well as the forecast for the city' do
     
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
    end
  end
end