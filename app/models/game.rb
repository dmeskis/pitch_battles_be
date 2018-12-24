class Game < ApplicationRecord
  validates_presence_of :total_duration,
                        :remaining_life
  belongs_to :user
  belongs_to :teacher, class_name: "User"
  has_many :klass_games
  has_many :klasses, through: :klass_games
end
