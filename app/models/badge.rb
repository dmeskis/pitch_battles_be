class Badge < ApplicationRecord
  validates_presence_of :name,
                        :description
  has_many :user_badges
  has_many :users, through: :user_badges
end
