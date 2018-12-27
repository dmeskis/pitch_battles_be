class Klass < ApplicationRecord
  validates_presence_of :name, :teacher_id
  validates_uniqueness_of :class_key
  before_save :create_class_key
  belongs_to :teacher, class_name: "User"
  has_many :user_klasses
  has_many :users, through: :user_klasses
  has_many :klass_games
  has_many :games, through: :klass_games

  private

    def create_class_key
      loop do
        class_key = self.class_key = SecureRandom.urlsafe_base64
        break class_key unless self.class.exists?(class_key: class_key)
      end
    end
end
