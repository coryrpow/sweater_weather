require "rails_helper"

RSpec.describe 'Munchies API endpoint' do

  location = 
  describe "/api/v1/munchies" do
    it "get requests all data needed for the landing page" do
      VCR.use_cassette("munchie_get") do
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

        munch = munchies[:data][:attributes]

        expect(munch[:destination_city]).to be_a(String)
        expect(munch[:destination_city]).to eq("Pueblo,CO")

        expect(munch[:forecast]).to be_a(Hash)
        expect(munch[:forecast].keys.count).to eq(2)

        #this changes too often, I need to get vcr in here to test this info that changes too rapidly

        expect(munch[:forecast][:temperature]).to eq(3.9)
        expect(munch[:forecast]).to have_key(:temperature)
        expect(munch[:forecast][:temperature]).to be_a(Float)

        expect(munch[:forecast][:summary]).to eq("Overcast")
        expect(munch[:forecast]).to have_key(:summary)
        expect(munch[:forecast][:summary]).to be_a(String)
        # require 'pry';binding.pry
      
        expect(munch[:restaurant]).to be_a(Hash)
        expect(munch[:restaurant].keys.count).to eq(4)

        expect(munch[:restaurant]).to have_key(:name)
        expect(munch[:restaurant][:name]).to be_a(String)
        expect(munch[:restaurant][:name]).to eq("La Forchetta Da Massi")
        expect(munch[:restaurant]).to have_key(:address)
        expect(munch[:restaurant][:address]).to be_a(String)
        expect(munch[:restaurant][:address]).to eq("126 S Union Ave, Pueblo, CO 81003")
        expect(munch[:restaurant]).to have_key(:rating)
        expect(munch[:restaurant][:rating]).to be_a(Float)
        expect(munch[:restaurant][:rating]).to eq(4.5)
        expect(munch[:restaurant]).to have_key(:reviews)
        expect(munch[:restaurant][:reviews]).to be_a(Integer)
        expect(munch[:restaurant][:reviews]).to eq(230)
      end
    end
  end
end