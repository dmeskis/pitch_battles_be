require 'factory_bot_rails'
require 'database_cleaner'

# Clean database everytime you seed
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
# Create badges
FactoryBot.create(:badge, id: 2, name: "play 5 games", description: "Play five games." )
FactoryBot.create(:badge, id: 3, name: "level one: completed", description: "Complete level one.")
FactoryBot.create(:badge, id: 4, name: "level one: perfect", description: "Complete level one without losing any lives.")
FactoryBot.create(:badge, id: 6, name: "level two: completed", description: "Complete level two.")
FactoryBot.create(:badge, id: 7, name: "level two: perfect", description: "Complete level two without losing any lives." )
FactoryBot.create(:badge, id: 9, name: "level three: completed", description: "Complete level three." )
FactoryBot.create(:badge, id: 11, name: "level three: perfect", description: "Complete level three without losing any lives." )
FactoryBot.create(:badge, id: 12, name: "level four: completed", description: "Complete level four." )
FactoryBot.create(:badge, id: 14, name: "level four: perfect", description: "Complete level four without losing any lives." )
FactoryBot.create(:badge, id: 1, name: "all levels: perfect", description: "Complete all levels without losing any lives." )
FactoryBot.create(:badge, id: 5, name: "play 10 games", description: "Play ten games." )
FactoryBot.create(:badge, id: 8, name: "play 20 games", description: "Play twenty games.")
FactoryBot.create(:badge, id: 10, name: "play 50 games", description: "Play fifty games." )
FactoryBot.create(:badge, id: 13, name: "play 100 games", description: "Play one-hundred games." )
FactoryBot.create(:badge, id: 15, name: "play 200 games", description: "Play two-hundred games." )
FactoryBot.create(:badge, id: 16, name: "play 500 games", description: "Play five-hundred games." )
FactoryBot.create(:badge, id: 17, name: "play 1000 games", description: "Play one-thousand games." )

# Create games and users
# Factory bot creates a user associated with a game
10.times do
  FactoryBot.create(:game)
end

# Create a class
klass = FactoryBot.create(:klass)

# Add users to class
User.all.each do |user|
  klass.users << user
end

# Give each user a random badge
badges = Badge.all
User.all.each do |user|
  user.badges << badges.sample
end