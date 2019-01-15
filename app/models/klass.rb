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
    { score: fastest, user: BareUserSerializer.new(User.where(level_one_fastest_time: fastest)) }
  end

  def level_two_fastest_time
    fastest = self.users.where.not(level_two_fastest_time: 0).minimum(:level_two_fastest_time)
    { score: fastest, user: BareUserSerializer.new(User.where(level_two_fastest_time: fastest)) }
  end

  def level_three_fastest_time
    fastest = self.users.where.not(level_three_fastest_time: 0).minimum(:level_three_fastest_time)
    { score: fastest, user: BareUserSerializer.new(User.where(level_three_fastest_time: fastest)) }
  end

  def level_four_fastest_time
    fastest = self.users.where.not(level_four_fastest_time: 0).minimum(:level_four_fastest_time)
    { score: fastest, user: BareUserSerializer.new(User.where(level_four_fastest_time: fastest)) }
  end

  def overall_fastest_time
    fastest = self.users.where.not(total_fastest_time: 0).minimum(:total_fastest_time)
    { score: fastest, user: BareUserSerializer.new(User.where(total_fastest_time: fastest)) }
  end
  
  def most_games
    most = users.maximum(:total_games_played)
    if most.nil?
      return nil
    else
      { games_played: most, user: BareUserSerializer.new(users.where(total_games_played: most)) }
    end
  end

  def most_badges
    most = users.select("users.id, count(badges.id) AS badge_count").
                 joins(:user_badges).
                 joins(:badges).
                 group("users.id").
                 order("badge_count DESC").
                 limit(1).
                 first
    if most.nil?
      return nil
    else
      { badges: most.badges.count, user: BareUserSerializer.new(users.where(id: most.id)) }
    end
  end

  def teacher?(instructor)
    self.teacher == instructor
  end

  def users_cache_key(users)
    {
      serializer: 'klass_students',
      stat_record: users.maximum(:updated_at)
    }
  end

  private

    def create_class_key
      loop do
        class_key = self.class_key = SecureRandom.urlsafe_base64
        break class_key unless self.class.exists?(class_key: class_key)
      end
    end
end
