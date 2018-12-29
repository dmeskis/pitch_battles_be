require 'rails_helper'

RSpec.describe BadgeAnalysis do
  before :each do
    10.times do 
      create(:badge)
    end
  end
  it 'exists' do
    game = create(:game)
    ba = BadgeAnalysis.new(game)
    expect(ba).to be_kind_of(BadgeAnalysis)
  end
  
end