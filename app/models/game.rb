class Game < ApplicationRecord
  belongs_to :user, counter_cache: :total_games_played
  has_many :klass_games
  has_many :klasses, through: :klass_games
  before_save :update_user_scores

  def update_user_scores
    if level_one_duration.present?
      if user.level_one_fastest_time.zero? || user.level_one_fastest_time > level_one_duration then user.level_one_fastest_time = level_one_duration end
    end
    if level_two_duration.present?
      if user.level_two_fastest_time.zero? || user.level_two_fastest_time > level_two_duration then user.level_two_fastest_time = level_two_duration end
    end
    if level_three_duration.present?
      if user.level_three_fastest_time.zero? || user.level_three_fastest_time > level_three_duration then user.level_three_fastest_time = level_three_duration end
    end
    if level_four_duration.present?
      if user.level_four_fastest_time.zero? || user.level_four_fastest_time > level_four_duration then user.level_four_fastest_time = level_four_duration end
    end
    if total_duration.present?
      if user.total_fastest_time.zero? || user.total_fastest_time > total_duration then user.total_fastest_time = total_duration end
    end
    user.save
  end

end
