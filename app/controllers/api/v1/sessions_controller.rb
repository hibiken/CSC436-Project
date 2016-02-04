class Api::V1::SessionsController < ApplicationController

  def create
    email, password = params[:session][:email], params[:session][:password]
    user = User.find_by(email: email)

    if user && user.authenticate(password)
      user.set_auth_token
      user.save
      render json: user.reload, status: 200, location: [:api, user]
    else
      render json: { errors: "Invalid email or password" }, status: 422
    end
  end

  def destroy
    user = User.find_by!(auth_token: params[:id])
    user.delete_auth_token
    head 204
  end
end
