require 'rails_helper'

RSpec.describe YelpService do
  context 'class methods' do
    context '#get_city_weather' do
      it 'returns a hash of weather data for specific lat and lon coordinates' do
        restaurant = YelpService.get_restaurant("italian", 38.26375, -104.61252)
        # require 'pry';binding.pry
        expect(restaurant).to be_a(Hash)

        expect(restaurant).to have_key(:name)
        expect(restaurant[:name]).to be_a(String)
        expect(restaurant).to have_key(:address)
        expect(restaurant[:address]).to be_a(String)
        expect(restaurant).to have_key(:rating)
        expect(restaurant[:rating]).to be_a(Float)
        expect(restaurant).to have_key(:reviews)
        expect(restaurant[:reviews]).to be_a(Integer)

      end
    end
  end
end
