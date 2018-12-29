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
    game = create_game
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
                    :user_id,
                    :times,
                    :perfectScores
                    )
    end

    def set_variables
      @game = Game.where(id: params[:id]).first
    end

    def create_game
      Game.new(
        level_one_duration: game_params[:times][0],
        level_two_duration: game_params[:times][1],
        level_three_duration: game_params[:times][2],
        level_four_duration: game_params[:times][3],
        total_duration: game_params[:times][4],
        user_id: @current_user.id,
        level_one_perfect: game_params[:perfectScores][:one],
        level_two_perfect: game_params[:perfectScores][:two],
        level_three_perfect: game_params[:perfectScores][:three],
        level_four_perfect: game_params[:perfectScores][:four],
        all_perfect: game_params[:perfectScores][:all]
      )
    end
end