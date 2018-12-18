class Klass < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :class_key
  before_save :create_class_key
  has_many :usersklasses
  has_many :users, through: :usersklasses
  has_many :klassesgames
  has_many :games, through: :klassesgames

  private

    def create_class_key
      loop do
        class_key = self.class_key = SecureRandom.urlsafe_base64
        break class_key unless self.class.exists?(class_key: class_key)
      end
    end
end
