class Api::V1::Users::GamesController < ApplicationController
  
  def index
    user = User.find(params[:id])
    if user
      render json: UserGamesSerializer.new(user).serialized_json, status: 200
    else
      render json: {"Error": "User not found."}, status: 404
    end
  end
end