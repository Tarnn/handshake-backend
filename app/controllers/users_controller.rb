class UsersController < ApplicationController
  # before_action :authenticate_user

  # GET /index
  def index
    @users = UserService.fetch_all_users
    Rails.logger.info("Users fetched successfully")
    render json: @users.as_json(only: [:id, :first_name, :last_name, :check_in_time])
  rescue => e
    Rails.logger.error("Error fetching users: #{e.message}")
    render json: { errors: { base: "Error fetching users: #{e.message}" } }, status: :internal_server_error
  end
end 

private

def authenticate_user
  token = request.headers['Authorization']&.split(' ')&.last
  unless token == 'your-secret-token' # Replace with real auth (e.g., JWT, API key)
    Rails.logger.warn("Unauthorized access attempt")
    render json: { errors: { base: "Unauthorized" } }, status: :unauthorized
  end
end