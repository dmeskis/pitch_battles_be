class Api::V1::Users::GamesController < ApplicationController
  before_action :set_user

  def index
    if @user
      render json: UserGamesSerializer.new(@user).serialized_json, status: 200
    else
      render json: {"error": "User not found."}, status: 404
    end
  end

end