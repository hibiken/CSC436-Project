class Api::V1::PostsController < ApplicationController
  before_action :authenticate_with_token!, except: [:index, :show]

  def index
    posts = Post.all
    render json: posts, status: 200
  end

  def show
    post = Post.find(params[:id])
    render json: post, status: 200
  end

  def create
    post = current_user.posts.new(post_params)
    if post.save
      render json: post, status: 201, location: [:api, current_user, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  def update
    post = current_user.posts.find(params[:id])
    if post.update(post_params)
      render json: post, status: 200, location: [:api, current_user, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
