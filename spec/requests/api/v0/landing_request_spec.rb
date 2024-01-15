require "rails_helper"

RSpec.describe 'Landing Page API endpoints' do
  describe "/api/v0/weather" do
    it "get requests all calls for the landing page" do
      # location = create(:location)
      location = Location.create!(city: "Denver", state: "CO")

      get "/api/v0/forecast?location=#{location.city},#{location.state}"

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)


    end
  end

end
