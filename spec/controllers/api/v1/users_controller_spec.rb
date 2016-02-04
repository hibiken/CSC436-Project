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

end
