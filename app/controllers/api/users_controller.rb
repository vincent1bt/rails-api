class Api::UsersController < ApplicationController
  def index
    @user = User.first
    render json: @user.posts
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = create_token(@user)
      render json: { auth_token: token }, status: :created
    else
      render json: { error: @user.errors }, status: :bad_request
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
