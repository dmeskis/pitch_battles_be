class Api::V1::UsersController < ApplicationController

  def new
    user = User.new(user_params)
    if user.save
      render json: {"success": "Account successfully created!"}
    else
      render json: {"error": "Account creation failed."}
    end
  end

  private
  
    def user_params
      params.permit(:email, :first_name, :last_name, :role, :password, :password_confirmation)
    end
end