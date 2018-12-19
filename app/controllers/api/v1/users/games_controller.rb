class Api::V1::Users::GamesController < ApplicationController
  
  def index
    user = User.where(id: params[:id]).first
    if user
      render json: UserGamesSerializer.new(user).serialized_json, status: 200
    else
      render json: {"error": "User not found."}, status: 404
    end
  end
end