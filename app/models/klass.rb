class Klass < ApplicationRecord
  validates_presence_of :name, :teacher_id
  validates_uniqueness_of :class_key
  before_save :create_class_key
  belongs_to :teacher, class_name: "User"
  has_many :users
  has_many :klass_games
  has_many :games, through: :klass_games

  def level_one_fastest_time
    fastest = self.users.where.not(level_one_fastest_time: 0).minimum(:level_one_fastest_time)
    User.where(level_one_fastest_time: fastest)
  end

  def level_two_fastest_time
    fastest = self.users.where.not(level_two_fastest_time: 0).minimum(:level_two_fastest_time)
    User.where(level_two_fastest_time: fastest)
  end

  def level_three_fastest_time
    fastest = self.users.where.not(level_three_fastest_time: 0).minimum(:level_three_fastest_time)
    User.where(level_three_fastest_time: fastest)
  end

  def level_four_fastest_time
    fastest = self.users.where.not(level_four_fastest_time: 0).minimum(:level_four_fastest_time)
    User.where(level_four_fastest_time: fastest)
  end

  def overall_fastest_time
    fastest = self.users.where.not(total_fastest_time: 0).minimum(:total_fastest_time)
    User.where(total_fastest_time: fastest)
  end
  
  def most_games
    most = users.maximum(:total_games_played)
    User.where(total_games_played: most)
  end

  def most_badges
    binding.pry
  end

  private

    def create_class_key
      loop do
        class_key = self.class_key = SecureRandom.urlsafe_base64
        break class_key unless self.class.exists?(class_key: class_key)
      end
    end
end
