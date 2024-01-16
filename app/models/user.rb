class User < ApplicationRecord
  before_create :api_key_creation
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: {allow_blank: false }

private
  def api_key_creation
    self.api_key ||= SecureRandom.hex(10) 
  end
end
