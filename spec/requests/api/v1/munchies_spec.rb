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
      # require 'pry';binding.pry

      expect(munchies).to be_a(Hash)
      expect(munchies[:data]).to be_a(Hash)
      expect(munchies[:data][:id]).to be(nil)
      expect(munchies[:data][:type]).to eq("munchie")
      expect(munchies[:data][:attributes]).to be_a(Hash)
      expect(munchies[:data][:attributes].keys.count).to eq(3)

      expect(munchies[:data][:attributes]).to have_key(:destination_city)
      expect(munchies[:data][:attributes]).to have_key(:forecast)
      expect(munchies[:data][:attributes]).to have_key(:restaurant)

      munch1 = munchies[:data][:attributes]

      expect(munch1[:destination_city]).to be_a(String)
      expect(munch1[:destination_city]).to eq("pueblo,co")

      expect(munch1[:forecast]).to be_a(Hash)
      expect(munch1[:forecast].keys.count).to eq(2)

      expect(munch1[:forecast][:temperature]).to eq(5.0)
      expect(munch1[:forecast][:temperature]).to be_a(Float)

      expect(munch1[:forecast][:summary]).to eq("Overcast")
      expect(munch1[:forecast][:summary]).to be_a(String)
      expect(munch)

    end
  end
end