require "rails_helper"

RSpec.describe 'Registration Page API endpoints' do
  describe "/api/v0/users" do
    it "get recieves user registration and returns an api_key" do
      user_params = ({
        "email": "coolguy@cool.com",
        "password": "cellardoor",
        "password_confirmation": "cellardoor"
      })
      headers = {"CONTENT_TYPE" => "application/json"}
    
      post "/api/v0/users", headers: headers, params: JSON.generate

      expect(response).to be_successful
      expect(response.status).to eq(200)

      forecast = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
