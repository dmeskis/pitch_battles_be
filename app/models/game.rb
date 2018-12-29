class Game < ApplicationRecord
  belongs_to :user
  has_many :klass_games
  has_many :klasses, through: :klass_games
end
