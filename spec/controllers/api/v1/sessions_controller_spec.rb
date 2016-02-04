require 'rails_helper'

RSpec.describe Api::V1::SessionsController do
  before(:each) do
    set_api_accept_header(version: 1)
    set_content_type_header(Mime::JSON.to_s)
  end

  describe "POST #create" do
    before(:each) do
      @user = create(:user, password: "password", auth_token: nil)
    end

    context "with correct credential" do
      before(:each) do
        credentials = { email: @user.email, password: "password" }
        post :create, { session: credentials }
      end

      it "renders the user record correspoding the given credentials" do
        user = json(response.body)
        @user.reload
        expect(user[:auth_token]).to eq(@user.auth_token)
      end

      it "responds with HTTP status 200" do
        expect(response.status).to eq(200)
      end
    end

    context "with incorrect credential" do
      before(:each) do
        incorrect_credentials = { email: @user.email, password: "invalid" }
        post :create, { session: incorrect_credentials }
      end

      it "renders JSON with error message" do
        user = json(response.body)
        expect(user[:errors]).to eq("Invalid email or password")
      end

      it "responds with HTTP status 422" do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create(:user)
      # Imitate log in by creating auth_token for the user.
      @user.set_auth_token
      @user.save

      delete :destroy, id: @user.auth_token
    end

    it "sets auth_token to nil" do
      @user.reload
      expect(@user.auth_token).to be_nil
    end

    it "responds with HTTP status 204" do
      expect(response.status).to eq(204)
    end
  end

end
