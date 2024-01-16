class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if User.exists?(email: user.email)
      render json: email_taken(user), status: :unprocessable_entity
    elsif user.password != user.password_confirmation
      render json: password_error(user), status: :unprocessable_entity
    else user.save
      render json: UserSerializer.new(user), status: :created
      # render json: user_creation_response(user), status: :created
    end
    # require 'pry';binding.pry
  end



  private

  def user_creation_response(user)
    {
      status: 201,
      body: {
        data: {
          type: 'users',
          id: user.id,
          attributes: {
            email: user.email,
            api_key: user.api_key
          }
        }
      }
    }
  end

  def email_taken(user)
    {
      error: "This email already has an account with us.",
      status: 422
    }
  end

  def password_error(user)
    # require 'pry';binding.pry
    {
      # error: "#{user.errors[:password_confirmation]}",
      error: "doesn't match Password",
      status: 422
    }
  end
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end


end