require 'rails_helper'

RSpec.describe Api::V1::PostsController do
  before(:each) do
    set_api_accept_header(version: 1)
    set_content_type_header(Mime::JSON.to_s)
  end

  describe "GET #show" do
    before(:each) do
      @user = create(:user)
      @post = create(:post, user: @user)
      get :show, { user_id: @user.id, id: @post.id }
    end

    it "returns requested post in JSON format" do
      post_response = json(response.body)
      expect(post_response[:title]).to eq(@post.title)
    end

    it "responds with HTTP status 200" do
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    before(:each) do
      @user = create(:user)
      @post_attributes = { title: "Post title", content: "some cool content" }
      post :create, { user_id: @user.id, post: @post_attributes }
    end

    it "returns newly created post in JSON format" do
      post_response = json(response.body)
      expect(post_response[:email]).to eq(@post_attributes[:email])
    end

    it "responds with HTTP status 201" do
      expect(response.status).to eq(201)
    end
  end

end
