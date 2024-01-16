require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email)}  
    it { should validate_uniqueness_of(:email)}  
    it { should validate_presence_of(:password)}  
    it { should validate_confirmation_of(:password)}  
  end

  describe "user password" do
    it "creates a user with a password that is secure" do
      user = User.create!(email: 'fake@fake.com', password: 'Bruh', password_confirmation: 'Bruh')

      expect(user.password == user.password_confirmation).to be
      expect(user.valid?).to eq(true)
    end

    it "does NOT create a user with a password that doesn't match password_confirmation" do
      user = User.new(email: 'fake@fake.com', password: 'Bruh', password_confirmation: 'Bro')
      expect(user.save).to eq(false)
      # require 'pry';binding.pry
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  describe "api_key creaiton" do
    it "creates an api_key upon successful creation of a user" do
      user = User.create!(email: 'fake@fake.com', password: 'Bruh', password_confirmation: 'Bruh')

      expect(user.api_key).to_not be(nil)

    end
  end
end
