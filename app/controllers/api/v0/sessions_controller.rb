class Api::V0::SessionsController < ApplicationController

  def create
    user = User.find_by(email: user_params[:email])
    if user
      if user.authenticate(user_params[:password])
        render json: UserSerializer.new(user), status: 200
      else
        render json: { error: "Bzzt, wrongo. Please try again.", status: 401}, status: 401
      end
    else
      render json: { error: "Bzzt, wrongo. Please try again.", status: 401}, status: 401
    end
  end

private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end