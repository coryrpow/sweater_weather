class Api::V0::SessionsController < ApplicationController

  def create
    # require 'pry';binding.pry
    user = User.find_by(email: user_params[:email])
    if user
      if user.authenticate(user_params[:password])
        render json: UserSerializer.new(user), status: 200
      else
        render json: { error: "Bzzt, wrongo. Please try again."}, status: 401
      end
    else
      render json: { error: "Bzzt, wrongo. Please try again."}, status: 401
    end
  end

  # No idea why I'm getting a 404 sometimes or it's returning as successful? 
  # def create
  #   # require 'pry';binding.pry
  #   user = User.find_by(email: params[:email])
  #   if user && user.authenticate(params[:password])
  #     render json: UserSerializer.new(user), status: 200
  #   else
  #     render json: { error: "Bzzt, wrongo. Please try again.", status: 400 }
  #   end
  # end

private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end