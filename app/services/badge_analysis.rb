class BadgeAnalysis

  def initialize(game)
    @user = game.user
    @game = game
  end

  def analyze
    # game_attributes = @game.slice(:level_one_duration, :level_two_duration, :level_three_attributes)
    # binding.pry
    # if @user.level_one_fastest_time < @game.level_one_duration
    #   @user.level_one_fastest_time = @game.level_one_duration
    # end
    # if @user.level_two_fastest_time < @game.level_two_duration
    #   @user.level_one_fastest_time = @game.level_two_duration
    # end
    # if @user.level_three_fastest_time < @game.level_three_duration
    #   @user.level_one_fastest_time = @game.level_three_duration
    # end
    # if @user.level_four_fastest_time < @game.level_four_duration
    #   @user.level_one_fastest_time = @game.level_four_duration
    # end
    # if @user.total_fastest_time < @game.total_duration
    #   @user.total_fastest_time = @game.total_duration
    # end
  end

end