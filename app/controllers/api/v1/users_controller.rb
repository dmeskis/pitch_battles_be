class Api::V1::UsersController < ApplicationController

  def show
    user = User.where(id: user_params[:id]).first
    if user
      render json: UserSerializer.new(user).serialized_json, status: 200
    else
      render json: {"error": "User not found."}, status: 404
    end
  end

  def new
    user = User.new(user_params)
    if user.save
      render json: {"success": "Account successfully created!"}, status: 200
    else
      render json: {"error": "Account creation failed."}, status: 400
    end
  end

  private
  
    def user_params
      params.permit(:id,
                    :email,
                    :first_name, 
                    :last_name, 
                    :role,
                    :password,
                    :password_confirmation)
    end
end