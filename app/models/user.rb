class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  has_secure_password
  validates_presence_of :first_name,
                        :last_name,
                        :password,
                        :role
  has_many :usersklasses
  has_many :klasses, through: :usersklasses
end
