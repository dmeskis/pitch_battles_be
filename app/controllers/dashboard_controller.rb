class DashboardController < ApplicationController

  def show
    if @current_user
      render json: UserSerializer.new(@current_user).serialized_json, status: 200
    else
      render json: {"error": "Please log in to view dashboard."}, status: 403
    end
  end

end