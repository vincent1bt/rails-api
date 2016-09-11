class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      return HashWithIndifferentAccess.new(body), nil
    rescue JWT::ExpiredSignature
      return nil, self.token_expired
    rescue JWT::VerificationError
      return nil, self.bad_token
    rescue JWT::DecodeError
      return nil, self.bad_token
    else
      return nil, self.bad_token
    end

    def token_expired
      "Token Expired"
    end

    def bad_token
      "Bad Token"
    end

    def no_token
      "No token"
    end
  end
end
