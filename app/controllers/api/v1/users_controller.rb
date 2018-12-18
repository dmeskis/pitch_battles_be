class Api::V1::UsersController < ApplicationController

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
      params.permit(:email, :first_name, :last_name, :role, :password, :password_confirmation)
    end
end