require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'exists' do
    game = create(:game)
    Game.where(total_duration: game.total_duration).should exist
  end
  describe 'validations' do
    it { should validate_presence_of :total_duration }
    it { should validate_presence_of :remaining_life }
  end
  describe 'relationships' do
    it { should belong_to :user}
  end
end
