class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates_presence_of :first_name,
                        :last_name,
                        :role
  has_many :user_klasses
  has_many :klasses, -> { distinct }, through: :user_klasses
  has_many :games
  has_many :user_badges
  has_many :badges, through: :user_badges
  enum role: [:student, :teacher]

end
