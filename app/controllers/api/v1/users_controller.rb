class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :params_empty?, only: :update

  def show
    user = User.where(id: params[:id]).first
    if user
      render json: UserSerializer.new(user).serialized_json, status: 200
    else
      render json: {"error": "User not found."}, status: 404
    end
  end

  def update
    if @current_user.update(update_params)
      render json: UserSerializer.new(@current_user).serialized_json, status: 200
    else
      render json: {"error": "Updating account failed. Please try again."}, status: 500
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {"success": "Account successfully created!"}, status: 200
    else
      render json: {"error": "Account creation failed."}, status: 400
    end
  end

  private
  
    def user_params
      params.permit(:email,
                    :first_name, 
                    :last_name, 
                    :role,
                    :password,
                    :password_confirmation)
    end

    def update_params
      params.permit(:email,
                    :first_name, 
                    :last_name,
                    :avatar,
                    :password,
                    :password_confirmation)
    end

    def params_empty?
      unless update_params.empty? != true
        render json: {error: "No update fields submitted. Resend request with valid update fields."}, status: 422
      end
    end
end