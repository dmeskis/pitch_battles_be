class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates_presence_of :first_name,
                        :last_name,
                        :role
  before_save :generate_auth_token
  has_many :user_klasses
  has_many :klasses, through: :user_klasses
  has_many :games
  has_many :user_badges
  has_many :badges, through: :user_badges

  private 

  def generate_auth_token
    loop do
      token = self.auth_token = SecureRandom.urlsafe_base64
      break token unless self.class.exists?(auth_token: auth_token)
    end
  end

end
