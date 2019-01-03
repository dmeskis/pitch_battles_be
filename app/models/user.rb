class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates_presence_of :first_name,
                        :last_name,
                        :role
  belongs_to :klass, optional: true, touch: true
  has_many :games, dependent: :destroy
  has_many :user_badges
  has_many :badges, -> { distinct }, through: :user_badges
  enum role: [:student, :teacher]
  before_save :downcase_email

  def downcase_email
    self.email.downcase! unless self.email.nil?
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end
  
  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end
  
  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!
  end

  def self.level_one_highscores
    order(level_one_fastest_time: :asc).where.not(level_one_fastest_time: 0).limit(100)
  end

  def self.level_two_highscores
    order(level_two_fastest_time: :asc).where.not(level_two_fastest_time: 0).limit(100)
  end

  def self.level_three_highscores
    order(level_three_fastest_time: :asc).where.not(level_three_fastest_time: 0).limit(100)
  end

  def self.level_four_highscores
    order(level_four_fastest_time: :asc).where.not(level_four_fastest_time: 0).limit(100)
  end

  def self.overall_highscores
    order(total_fastest_time: :asc).where.not(total_fastest_time: 0).limit(100)
  end

  def game_cache_key(games)
    {
      serializer: 'user_games',
      stat_record: games.maximum(:updated_at)
    }
  end

  def badge_cache_key(badges)
    {
      serializer: 'user_badges',
      stat_record: badges.maximum(:updated_at)
    }
  end
  
  private
  
  def generate_token
    SecureRandom.hex(10)
  end

end
