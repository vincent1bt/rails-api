class Api::SessionController < ApplicationController
  def authenticate
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      token = create_token(user)
      render json: { auth_token: token }, status: :created
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end
end
