class Game < ApplicationRecord
  validates_presence_of :total_duration
  belongs_to :user
  has_many :klass_games
  has_many :klasses, through: :klass_games
end
