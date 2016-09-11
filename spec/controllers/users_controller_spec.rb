require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  let(:valid_user) {
    attributes_for(:user)
  }

  describe "POST #create" do
    it "create a new user" do
      expect {
        post :create, { user: valid_user }
      }.to change(User, :count).by(1)
    end

    it "returns token" do
      post :create, { user: valid_user }
      json = JSON.parse(response.body)
      expect(json["auth_token"]).not_to be_empty
    end
  end

end
