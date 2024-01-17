require 'rails_helper'

RSpec.describe MunchieSerializer do
  describe '#facade methods', :vcr do
    it 'returns json when given a munchie poro' do
      munchie_poro = MunchiesFacade.get_munchie("pueblo,co", "italian")
      serialize = MunchieSerializer.new(munchie_poro)
      
      
      
      munchie = JSON.parse(serialize.to_json, symbolize_names: true)
      
      # require 'pry';binding.pry
      expect(munchie).to have_key(:data)
      expect(munchie[:data]).to be_a(Hash)
      expect(munchie[:data]).to have_key(:id)
      expect(munchie[:data][:id]).to be(nil)

      expect(munchie[:data][:attributes].keys.count).to eq(3)

      expect(munchie[:data][:attributes]).to have_key(:destination_city)
      expect(munchie[:data][:attributes]).to have_key(:forecast)
      expect(munchie[:data][:attributes]).to have_key(:restaurant)

      munch = munchie[:data][:attributes]

      expect(munch[:destination_city]).to be_a(String)
      expect(munch[:destination_city]).to eq("pueblo,co")

      expect(munch[:forecast]).to be_a(Hash)
      expect(munch[:forecast].keys.count).to eq(2)

      # expect(munch[:forecast][:temperature]).to eq(3.9)
      expect(munch[:forecast]).to have_key(:temperature)
      expect(munch[:forecast][:temperature]).to be_a(Float)

      # expect(munch[:forecast][:summary]).to eq("Overcast")
      expect(munch[:forecast]).to have_key(:summary)
      expect(munch[:forecast][:summary]).to be_a(String)
      # require 'pry';binding.pry
    
      expect(munch[:restaurant]).to be_a(Hash)
      expect(munch[:restaurant].keys.count).to eq(4)

      expect(munch[:restaurant]).to have_key(:name)
      expect(munch[:restaurant][:name]).to be_a(String)
      # expect(munch[:restaurant][:name]).to eq("La Forchetta Da Massi")
      expect(munch[:restaurant]).to have_key(:address)
      expect(munch[:restaurant][:address]).to be_a(String)
      # expect(munch[:restaurant][:address]).to eq("126 S Union Ave, Pueblo, CO 81003")
      expect(munch[:restaurant]).to have_key(:rating)
      expect(munch[:restaurant][:rating]).to be_a(Float)
      # expect(munch[:restaurant][:rating]).to eq(4.5)
      expect(munch[:restaurant]).to have_key(:reviews)
      expect(munch[:restaurant][:reviews]).to be_a(Integer)
      # expect(munch[:restaurant][:reviews]).to eq(230)
    end
  end
end