require 'rails_helper'

RSpec.describe Api::V1::UsersController do
  before(:each) { request.headers['Accept'] = "application/vnd.socialmedia.v1+json" }

  describe "GET #show" do
    before(:each) do
      @user = create(:user)
      get :show, id: @user.id, format: :json
    end

    it "returns requested user data in JSON format" do
      user = JSON.parse(response.body, symbolize_names: true)
      expect(user[:email]).to eq(@user.email)
    end

    it "responds with HTTP status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "creation successful" do
      before(:each) do
        @user_attributes = attributes_for(:user)
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders the new user record in JSON format" do
        user = JSON.parse(response.body, symbolize_names: true)
        expect(user[:email]).to eq(@user_attributes[:email])
      end

      it "responds with HTTP status 201" do
        expect(response.status).to eq(201)
      end
    end

    context "creation unsuccessful" do
      before(:each) do
        @invalid_attributes = attributes_for(:user, email: " ")
        post :create, { user: @invalid_attributes }, format: :json
      end

      it "renders json with error message" do
        user = JSON.parse(response.body, symbolize_names: true)
        expect(user[:errors]).to be_present
      end

      it "responds with HTTP status 422" do
        expect(response.status).to eq(422)
      end
    end
  end

end
