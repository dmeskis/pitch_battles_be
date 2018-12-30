class Game < ApplicationRecord
  belongs_to :user, counter_cache: :total_games_played
  has_many :klass_games
  has_many :klasses, through: :klass_games
  before_save :update_user_scores

  def update_user_scores
    user = self.user
    if !self.level_one_duration.nil? && user.level_one_fastest_time < self.level_one_duration
      user.level_one_fastest_time = self.level_one_duration
    end
    if !self.level_two_duration.nil? && user.level_two_fastest_time < self.level_two_duration
      user.level_two_fastest_time = self.level_two_duration
    end
    if !self.level_three_duration.nil? && user.level_three_fastest_time < self.level_three_duration
      user.level_three_fastest_time = self.level_three_duration
    end
    if !self.level_four_duration.nil? && user.level_four_fastest_time < self.level_four_duration
      user.level_four_fastest_time = self.level_four_duration
    end
    if !self.level_one_duration.nil? && user.total_fastest_time < self.total_duration
      user.total_fastest_time = self.total_duration
    end
    user.save
  end

end
