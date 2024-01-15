require 'rails_helper'

RSpec.describe MapquestService do
  context 'class methods' do
    context '#get_location' do
      it 'returns lat and lon of a city', :vcr do
          location = Location.create!(city: "Denver", state: "CO")
          mapquest = MapquestService.get_location("#{location.city},#{location.state}")
          # require 'pry';binding.pry
          expect(mapquest).to be_a(Hash)

          expect(mapquest).to have_key(:lat)
          expect(mapquest).to have_key(:lng)
          expect(mapquest[:lat]).to be_a(Float)
          expect(mapquest[:lng]).to be_a(Float)
          expect(mapquest.keys.count).to eq(2)
      
      end
    end
  end
end
