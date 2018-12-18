class Game < ApplicationRecord
  validates_presence_of :total_duration,
                        :remaining_life
  belongs_to :user
  has_many :klassesgames
  has_many :klasses, through: :klassesgames
end
