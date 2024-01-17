require 'rails_helper'

RSpec.describe YelpService do
  context 'class methods' do
    context '#get_city_weather', :vcr do
      it 'returns a hash of weather data for specific lat and lon coordinates' do
        restaurant = YelpService.get_restaurant("italian", 38.26375, -104.61252)
        expect(restaurant).to be_a(Hash)

        expect(restaurant).to have_key(:name)
        expect(restaurant[:name]).to be_a(String)
        expect(restaurant[:name]).to eq("La Forchetta Da Massi")
        expect(restaurant).to have_key(:address)
        expect(restaurant[:address]).to be_a(String)
        expect(restaurant[:address]).to eq("126 S Union Ave, Pueblo, CO 81003")
        expect(restaurant).to have_key(:rating)
        expect(restaurant[:rating]).to be_a(Float)
        expect(restaurant[:rating]).to eq(4.5)
        expect(restaurant).to have_key(:reviews)
        expect(restaurant[:reviews]).to be_a(Integer)
        expect(restaurant[:reviews]).to eq(230)
      end
    end
  end
end
