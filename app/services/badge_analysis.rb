class BadgeAnalysis

  def initialize(game)
    @user = game.user
    @game = game
  end

  def analyze
    unearned_badges = (@user.badges + badge_list) - (@user.badges & badge_list).sort
    unearned_badges.each do |badge|
      badge_earned?(badge)
    end
  end

  def badge_earned?(badge)
    case badge.id
    when 1
      if @user.games.count >= 5
        @user.badges << badge
      end
    when 2
      if @game.level_one_duration
        @user.badges << badge
      end
    when 3
      if @game.level_one_perfect
        @user.badges << badge
      end
    when 4
      if @game.level_two_duration
        @user.badges << badge
      end
    when 5
      if @user.games.count >= 10
        @user.badges << badge
      end
    when 6
      if @game.level_two_perfect
        @user.badges << badge
      end
    when 7
      if @game.level_three_duration
        @user.badges << badge
      end
    when 8
      if @user.games.count >= 20
        @user.badges << badge
      end
    when 9
      if @game.level_three_perfect
        @user.badges << badge
      end
    when 10
      if @user.games.count >= 50
        @user.badges << badge
      end
    when 11
      if @game.level_four_duration
        @user.badges << badge
      end
    when 12
      if @game.level_four_perfect
        @user.badges << badge
      end
    when 13
      if @user.games.count >= 100
        @user.badges << badge
      end
    when 14
      if @game.all_perfect
        @user.badges << badge
      end
    when 15
      if @user.games.count >= 200
        @user.badges << badge
      end
    when 16
      if @user.games.count >= 500
        @user.badges << badge
      end
    when 17
      if @user.games.count >= 1000
        @user.badges << badge
      end
    end
  end

  private

  def badge_list
    Badge.all
  end

end