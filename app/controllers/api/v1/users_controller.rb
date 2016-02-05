class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:update]

  def show
    user = User.find(params[:id])
    render json: user, status: 200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    if current_user.update(user_params)
      render json: current_user, status: 200, location: [:api, current_user]
    else
      render json: { errors: current_user.errors }, status: 422
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end
end
