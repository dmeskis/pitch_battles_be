class Game < ApplicationRecord
  validates_presence_of :total_duration,
                        :remaining_life
  belongs_to :user
end
