class Game < ApplicationRecord
  belongs_to :user, counter_cache: :total_games_played
  has_many :klass_games
  has_many :klasses, through: :klass_games
end
