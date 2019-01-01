class Api::V1::GamesController < ApplicationController
  before_action :valid_params?, only: :create
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
      params.permit(
                    :times,
                    :perfectScores
                    )
    end

    def set_variables
      @game = Game.where(id: params[:id]).first
    end

    def create_game
      Game.new(
        level_one_duration: params[:times][:one],
        level_two_duration: params[:times][:two],
        level_three_duration: params[:times][:three],
        level_four_duration: params[:times][:four],
        total_duration: params[:times][:all],
        user_id: @current_user.id,
        level_one_perfect: params[:perfect_scores][:one],
        level_two_perfect: params[:perfect_scores][:two],
        level_three_perfect: params[:perfect_scores][:three],
        level_four_perfect: params[:perfect_scores][:four],
        all_perfect: params[:perfect_scores][:all]
      )
    end

    def valid_params?
      unless params[:times] && params[:perfect_scores]
        render json: {error: "Invalid game data."}, status: 422
      end
    end
end