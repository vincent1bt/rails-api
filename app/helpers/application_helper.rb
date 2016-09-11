module ApplicationHelper
  def authenticate_request_helper
    if get_token
      token = request.headers['Authorization'].split(' ').last
      token_decoded, error = JsonWebToken.decode(token)
      return nil, error if error
      user = User.find(token_decoded[:user_id])
    else
      return nil, JsonWebToken.no_token
    end
  end

  def create_token(user)
    JsonWebToken.encode(user_id: user.id)
  end

  private
    def get_token
      if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      else
        return nil
      end
    end
end
