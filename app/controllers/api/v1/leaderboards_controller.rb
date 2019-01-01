class Api::V1::LeaderboardsController < ApplicationController
  before_action :get_highscores

  def index
    options = {}
    options[:is_collection] = true
    options[:params] = {level: leaderboards_params[:type]}
    render json: LeaderboardSerializer.new(@scores, options).serialized_json, status: 200
  end

  private

  def leaderboards_params
    params.permit(:type)
  end

  def get_highscores
    case leaderboards_params[:type]
    when 'level_one'
      @scores = User.level_one_highscores
    when 'level_two'
      @scores = User.level_two_highscores
    when 'level_three'
      @scores = User.level_three_highscores
    when 'level_four'
      @scores = User.level_four_highscores
    when 'overall'
      @scores = User.overall_highscores
    else
      render json: {error: "Invalid type supplied."}, status: 422
    end
  end

end