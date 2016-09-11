require 'rails_helper'

RSpec.describe Api::SessionController, type: :controller do
  let(:user) {
    create(:user)
  }

  let(:user_params) {
    build_stubbed(:user)
  }

  describe "POST #authenticate" do
    it "should return token" do
      post :authenticate, { email: user.email, password: user_params.password }
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json["auth_token"]).not_to be_empty
    end
  end
end
