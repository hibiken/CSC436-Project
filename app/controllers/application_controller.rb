class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    unless current_user.present?
      render json: { errors: "Not authorized" }, status: 401
    end
  end

  def user_signed_in?
    current_user.present?
  end
end
