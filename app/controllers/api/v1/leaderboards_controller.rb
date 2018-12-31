class Api::V1::LeaderboardsController < ApplicationController
  before_action :get_highscores

  def index
    binding.pry
  end

  private

  def leaderboards_params
    params.permit(:type)
  end

  def get_highscores
    case leaderboards_params[:type]
    when 'level_one'
      @scores = Leaderboard.new(leaderboards_params[:type])
      @scores = User.order(level_one_fastest_time: :asc).limit(100)
    when 'level_two'
      @scores = Leaderboard.new(leaderboards_params[:type])
      @scores = User.order(level_two_fastest_time: :asc).limit(100)
    when 'level_three'
      @scores = Leaderboard.new(leaderboards_params[:type])
      @scores = User.order(level_three_fastest_time: :asc).limit(100)
    when 'level_four'
      @scores = Leaderboard.new(leaderboards_params[:type])
      @scores = User.order(level_four_fastest_time: :asc).limit(100)
    when 'overall'
      @scores = Leaderboard.new(leaderboards_params[:type])
      @scores = User.order(total_fastest_time: :asc).limit(100)
    else
      render json: {error: "Invalid type supplied."}, status: 422
    end
  end

end