class Api::V1::Users::GamesController < ApplicationController
  before_action :set_variables

  def index
    if @user
      render json: UserGamesSerializer.new(@user).serialized_json, status: 200
    else
      render json: {"error": "User not found."}, status: 404
    end
  end

  private

  def set_variables
    @user = User.where(id: params[:id]).first
  end

end