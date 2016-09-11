class ApplicationController < ActionController::Base
  include ApplicationHelper
  attr_reader :current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :null_session

  def authenticate_request
    user, error = authenticate_request_helper
    if error
      render json: { error: error }, status: 401
    else
      @current_user = user
    end
  end
end
