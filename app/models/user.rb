class User < ApplicationRecord
include ActiveModel::SecurePassword
  has_secure_password

  validates :email, presence: true, uniqueness: true
end
