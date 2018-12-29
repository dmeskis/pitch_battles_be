require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'exists' do
    game = create(:game)
    Game.where(total_duration: game.total_duration).should exist
  end
  describe 'attributes' do
    it 'has attributes' do
      game = create(:game)
      expect(game.attributes).to include("total_duration")
      expect(game.attributes).to include("level_one_duration")
      expect(game.attributes).to include("level_two_duration")
      expect(game.attributes).to include("level_three_duration")
      expect(game.attributes).to include("level_four_duration")
      expect(game.attributes).to include("user_id")
    end
  end
  describe 'validations' do
    it { should validate_presence_of :total_duration }
  end
  describe 'relationships' do
    it { should belong_to :user}
    it { should have_many :klasses}
  end
end
