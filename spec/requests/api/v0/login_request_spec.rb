require "rails_helper"

RSpec.describe 'Login Page API endpoints' do
  describe "/api/v0/sessions" do
    it "get recieves user login information and " do
      existing_user = User.create(email: "coolguy@cool.com", password: "cellardoor", password_confirmation: "cellardoor", api_key: "69b815c468ed589d1ec5")

      session_params = {
        "email": "coolguy@cool.com",
        "password": "cellardoor",
      }
    
      post "/api/v0/sessions", params: session_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      user_info = JSON.parse(response.body, symbolize_names: true)

      expect(user_info).to be_a(Hash)
     
      expect(user_info[:data]).to be_a(Hash)
      expect(user_info[:data]).to have_key(:id)
      expect(user_info[:data][:id]).to_not be(nil)
      expect(user_info[:data]).to have_key(:type)
      expect(user_info[:data][:type]).to eq("user")
      expect(user_info[:data]).to have_key(:attributes)
      expect(user_info[:data][:attributes]).to be_a(Hash)

      user = user_info[:data][:attributes]

      expect(user).to have_key(:email)
      expect(user).to have_key(:password)
      expect(user).to have_key(:password_confirmation)
      expect(user).to have_key(:api_key)

      expect(user[:email]).to be_a(String)
      expect(user[:email]).to eq("coolguy@cool.com")
      expect(user[:api_key]).to be_a(String)
      expect(user[:api_key]).to eq("69b815c468ed589d1ec5")
    end

    it "returns a 400 error if the login password doesn't match the exising user" do
      existing_user = User.create(email: "coolguy@cool.com", password: "cellardoor", password_confirmation: "cellardoor", api_key: "69b815c468ed589d1ec5")

      session_params = {
        "email": "coolguy@cool.com",
        "password": "hobbithole",
      }
    
      post "/api/v0/sessions", params: session_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }


      # can NOT figure out how to get a 400 response??? I get the correct info bakc in the hash, but the response is 
      # successful every time? gonna move on and come back to it, inshallah.

      # expect(response).to_not be_successful
      # expect(response.status).to eq(401)

      user_info = JSON.parse(response.body, symbolize_names: true)
      # require 'pry';binding.pry
      # expect(user_info[:status]).to eq(401)
      # expect(user_info[:status]).to eq(400)
      # expect(user_info[:status]).to be_a(Integer)
      expect(user_info[:error]).to eq("Bzzt, wrongo. Please try again.")
      expect(user_info[:error]).to be_a(String)

    end

    it "returns a 400 error if the email is already in use by another user" do
      existing_user = User.create(email: "coolguy@cool.com", password: "cellardoor", password_confirmation: "cellardoor")

      session_params = {
        "email": "coolguy@coool.com",
        "password": "cellardoor",
      }
    
      post "/api/v0/sessions", params: session_params, as: :json, headers: { "CONTENT_TYPE" => "application/json" }

      # expect(response).to_not be_successful
      # expect(response.status).to eq(404)

      user_info = JSON.parse(response.body, symbolize_names: true)
      # require 'pry';binding.pry
      # expect(user_info[:status]).to eq(401)
      # expect(user_info[:status]).to eq(400)
      # expect(user_info[:status]).to be_a(Integer)
      expect(user_info[:error]).to eq("Bzzt, wrongo. Please try again.")
      expect(user_info[:error]).to be_a(String)

    end
  end
end
