require 'rails_helper'

RSpec.describe BadgeAnalysis do
  before :each do
    create(:badge, id: 2, name: "play 5 games", description: "Play five games." )
    create(:badge, id: 3, name: "level one: completed", description: "Complete level one.")
    create(:badge, id: 4, name: "level one: perfect", description: "Complete level one without losing any lives.")
    create(:badge, id: 6, name: "level two: completed", description: "Complete level two.")
    create(:badge, id: 7, name: "level two: perfect", description: "Complete level two without losing any lives." )
    create(:badge, id: 9, name: "level three: completed", description: "Complete level three." )
    create(:badge, id: 11, name: "level three: perfect", description: "Complete level three without losing any lives." )
    create(:badge, id: 12, name: "level four: completed", description: "Complete level four." )
    create(:badge, id: 14, name: "level four: perfect", description: "Complete level four without losing any lives." )
    create(:badge, id: 1, name: "all levels: perfect", description: "Complete all levels without losing any lives." )
    create(:badge, id: 5, name: "play 10 games", description: "Play ten games." )
    create(:badge, id: 8, name: "play 20 games", description: "Play twenty games.")
    create(:badge, id: 10, name: "play 50 games", description: "Play fifty games." )
    create(:badge, id: 13, name: "play 100 games", description: "Play one-hundred games." )
    create(:badge, id: 15, name: "play 200 games", description: "Play two-hundred games." )
    create(:badge, id: 16, name: "play 500 games", description: "Play five-hundred games." )
    create(:badge, id: 17, name: "play 1000 games", description: "Play one-thousand games." )
  end
  it 'exists' do
    game = create(:game)
    ba = BadgeAnalysis.new(game)
    expect(ba).to be_kind_of(BadgeAnalysis)
  end
  
end