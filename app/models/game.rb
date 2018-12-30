class Game < ApplicationRecord
  belongs_to :user, counter_cache: :total_games_played
  has_many :klass_games
  has_many :klasses, through: :klass_games
  before_save :update_user_scores

  def update_user_scores
    user = self.user
    if !self.level_one_duration.nil?
      if user.level_one_fastest_time < self.level_one_duration then user.level_one_fastest_time = self.level_one_duration end
    end
    if !self.level_two_duration.nil?
      if user.level_two_fastest_time < self.level_two_duration then user.level_two_fastest_time = self.level_two_duration end
    end
    if !self.level_three_duration.nil?
      if user.level_three_fastest_time < self.level_three_duration then user.level_three_fastest_time = self.level_three_duration end
    end
    if !self.level_four_duration.nil?
      if user.level_four_fastest_time < self.level_four_duration then user.level_four_fastest_time = self.level_four_duration end
    end
    if !self.total_duration.nil?
      if user.total_fastest_time < self.total_duration then user.total_fastest_time = self.total_duration end
    end
    user.save
  end

end
