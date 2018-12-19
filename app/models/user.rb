class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates_presence_of :first_name,
                        :last_name,
                        :role
  has_many :usersklasses
  has_many :klasses, through: :usersklasses
  has_many :games
end
