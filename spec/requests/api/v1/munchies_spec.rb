require "rails_helper"

RSpec.describe 'Munchies API endpoint' do

  location = 
  describe "/api/v1/munchies" do
    it "get requests all data needed for the landing page" do
      location = Location.create!(city: "Pueblo", state: "CO")
      
      get "/api/v1/munchies?destination=#{location.city},#{location.state}&food=italian"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      munchies = JSON.parse(response.body, symbolize_names: true)

      expect(munchies).to be_a(Hash)
      expect(munchies[:data]).to be_a(Hash)
      expect(munchies[:data][:id]).to be(nil)
      expect(munchies[:data][:type]).to eq("munchie")
      expect(munchies[:data][:attributes]).to be_a(Hash)
      expect(munchies[:data][:attributes].keys.count).to eq(3)

      # expect(munchies[:data][:attributes]).to have_key(:)
      # expect(munchies[:data][:attributes]).to have_key(:daily_weather)
      # expect(munchies[:data][:attributes]).to have_key(:hourly_weather)

      munch = munchies[:data][:attributes]
      expect(munch)

    end
  end
end