class Api::V1::GamesController < ApplicationController

  def create
    game = Game.new(game_params)
    if game.save
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
                    :user_id
                    )
    end
end