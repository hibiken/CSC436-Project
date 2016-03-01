class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  skip_before_filter  :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

    def current_user
      return if request.headers['Authorization'].nil?
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

    def current_user?(user)
      return false unless current_user
      current_user.id == user.id
    end

    def not_found
      render json: { errors: "Not found" }, status: 404
    end
end
