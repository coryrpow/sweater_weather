class UserSerializer
  include JSONAPI::Serializer
  attributes :email,
             :password,
             :password_confirmation,
             :api_key
  # require 'pry';binding.pry
end