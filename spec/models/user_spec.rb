require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid' do
    user = create(:user)
    expect(user.valid?).to eq(true)
  end
  describe 'enum' do
    it 'is teacher?' do
      user = create(:user, role: 1)
      expect(user.teacher?).to eq(true)
    end
    it 'is student?' do
      user = create(:user, role: 0)
      expect(user.student?).to eq(true)
    end
  end
  describe 'attributes' do
    it 'has attributes' do
      user = create(:user)
      expect(user.attributes).to include("first_name")
      expect(user.attributes).to include("last_name")
      expect(user.attributes).to include("role")
      expect(user.attributes).to include("password_digest")
      expect(user.attributes).to include("avatar")
      expect(user.attributes).to include("level_one_fastest_time")
      expect(user.attributes).to include("level_two_fastest_time")
      expect(user.attributes).to include("level_three_fastest_time")
      expect(user.attributes).to include("level_four_fastest_time")
      expect(user.attributes).to include("total_fastest_time")
      expect(user.level_one_fastest_time).to eq(0)
      expect(user.level_two_fastest_time).to eq(0)
      expect(user.level_three_fastest_time).to eq(0)
      expect(user.level_four_fastest_time).to eq(0)
      expect(user.total_fastest_time).to eq(0)
    end
  end
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :password }
    it { should validate_presence_of :role }
    it { should validate_uniqueness_of :email }
  end
  describe 'relationships' do
    it { should belong_to :klasses }
    it { should have_many :games }
    it { should have_many :badges }
    it 'cannot have duplicate badges' do
      user = create(:user)
      badge = create(:badge)
      user.badges << badge
      user.badges << badge
      expect(user.badges.count).to eq(1)
    end
    it 'has a game counter' do
      user = create(:user)
      num_games = rand(0..10)
      num_games.times do
        create(:game, user_id: user.id)
      end

      expect(user.games.count).to eq(num_games)
    end
    it 'downcases email on create' do
      user = User.new(email: "TEST@MAIL.com",
                      first_name: "Test",
                      last_name: "Name",
                      password: "password",
                      password_confirmation: "password",
                      )
      user.save
      expect(user.email).to eq(user.email.downcase)
    end
  end
end