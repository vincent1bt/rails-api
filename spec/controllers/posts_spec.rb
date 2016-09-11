require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  let(:new_post) {
    create(:post)
  }

  let(:user) {
    create(:user)
  }

  let(:token) {
    subject.send(:create_token, user)
  }

  let(:valid_post) {
    {
      title: "Hola mundo",
      body: "Que tal"
    }
  }

  let(:valid_new_post) {
    {
      title: "Nuevo titulo",
      body: "Nuevo body"
    }
  }

  let(:invalid_post) {
    { title: "Solo tengo el titulo" }
  }

  describe "GET #index" do
    it "return http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before :each do
      get :show, { id: new_post.to_param }
    end

    it "get correct post" do
      expect(assigns(:post)).to eq(new_post)
    end

    it "return http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before :each do
        request.headers["Authorization"] = token
      end

      it "creates a new post" do
        expect {
          post :create, { post: valid_post }
        }.to change(Post, :count).by(1)
      end

      it "return json post" do
        post :create, { post: valid_post }
        json = JSON.parse(response.body)
        expect(json["post"]['title']).to eq("Hola mundo")
        expect(json["post"]['body']).to eq("Que tal")
      end
    end

    context "with invalid params" do
      before :each do
        request.headers["Authorization"] = token
      end

      before :each do
        post :create, { post: invalid_post }
      end

      it "return status 400" do
        expect(response).to have_http_status(400)
      end
    end

    context "when no token present" do
      it "returns 401 code" do
        post :create, { post: valid_post }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "PUT #update" do
    context "whith valid params" do
      before :each do
        request.headers["Authorization"] = token
      end

      it "updates post" do
        put :update, { id: new_post.to_param, post: valid_new_post }
        json = JSON.parse(response.body)
        expect(json["post"]['title']).to eq("Nuevo titulo")
      end

      it "returns code 200 " do
        put :update, { id: new_post.to_param, post: valid_new_post }
        expect(response).to have_http_status(200)
      end
    end

    context "when token no present" do
      it "should return code 401" do
        put :update, { id: new_post.to_param, post: valid_post }
        expect(response).to have_http_status(401)
      end
    end
  end
end
