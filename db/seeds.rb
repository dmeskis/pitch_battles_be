require 'factory_bot_rails'
require 'database_cleaner'

# Clean database everytime you seed
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
# Create badges
10.times do
  FactoryBot.create(:badge)
end

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