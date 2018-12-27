class Api::V1::DashboardController < ApplicationController

  def show
    render json: UserSerializer.new(@current_user).serialized_json, status: 200
  end

end