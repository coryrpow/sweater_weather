class UserSerializer
  include JSONAPI::Serializer
  attributes :email,
             :password,
             :password_confirmation,
             :api_key

end