class Api::V1::PostsController < ApplicationController

  def show
    post = Post.find(params[:id])
    render json: post, status: 200
  end

  def create
    user = User.find(params[:user_id])
    post = user.posts.new(post_params)
    if post.save
      render json: post, status: 201, location: [:api, user, post]
    else
      render json: { errors: post.errors }, status: 422
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
