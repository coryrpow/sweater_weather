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
    
      post "/api/v0/users", headers: headers, params: JSON.generate(user: user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      
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
      expect(user[:password]).to be_a(String)
      expect(user[:password]).to eq("cellardoor")
      expect(user[:password_confirmation]).to be_a(String)
      expect(user[:password_confirmation]).to eq("cellardoor")
      expect(user[:api_key]).to be_a(String)
    end

    it "returns a 400 error if the passwords don't match" do
      user_params = ({
        "email": "coolguy@cool.com",
        "password": "cellardoor",
        "password_confirmation": "hobbithole"
      })
      headers = {"CONTENT_TYPE" => "application/json"}
    
      post "/api/v0/users", headers: headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      user_info = JSON.parse(response.body, symbolize_names: true)
      # require 'pry';binding.pry
      expect(user_info[:status]).to eq(422)
      expect(user_info[:status]).to be_a(Integer)
      expect(user_info[:error]).to eq("doesn't match Password")
      expect(user_info[:error]).to be_a(String)

    end

    it "returns a 400 error if the email is already in use by another user" do
      existing_user = User.create!(email: "coolguy@cool.com", password: "cellardoor", password_confirmation: "cellardoor")

      user_params = ({
        "email": "coolguy@cool.com",
        "password": "cellardoor",
        "password_confirmation": "cellardoor"
      })
      headers = {"CONTENT_TYPE" => "application/json"}
    
      post "/api/v0/users", headers: headers, params: JSON.generate(user: user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      user_info = JSON.parse(response.body, symbolize_names: true)
      # require 'pry';binding.pry
      expect(user_info[:status]).to eq(422)
      expect(user_info[:status]).to be_a(Integer)
      expect(user_info[:error]).to eq("This email already has an account with us.")
      expect(user_info[:error]).to be_a(String)

    end
  end
end
