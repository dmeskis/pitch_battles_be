class Api::V1::GamesController < ApplicationController
  before_action :set_variables, only: :show

  def show
    if @game
      render json: GameSerializer.new(@game).serialized_json, status: 200
    else
      render json: {"error": "Game not found."}, status: 404
    end
  end

  def create
    game = Game.new(game_params)
    if game.save
      analysis = BadgeAnalysis.new(game).analyze
      render json: GameSerializer.new(game).serialized_json, status: 200
    else
      render json: {"error": "Failed to save game. Check error logs."}, status: 500
    end
  end

  private

    def game_params
      params.permit(:total_duration,
                    :level_one_duration,
                    :level_two_duration,
                    :level_three_duration,
                    :level_four_duration,
                    :remaining_life,
                    :user_id,
                    :times,
                    :perfectScores
                    )
    end

    def set_variables
      @game = Game.where(id: params[:id]).first
    end
end