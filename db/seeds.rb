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

# Create dev teacher accounts

dylan = User.create(first_name: "Dylan",
            last_name: "Meskis",
            email: "dmeskis@gmail.com",
            role: 1,
            password: "password",
            password_confirmation: "password")

kevin = User.create(first_name: "Kevin",
            last_name: "Simpson",
            email: "relasine@gmail.com",
            role: 1,
            password: "password",
            password_confirmation: "password")

haley = User.create(first_name: "Haley",
            last_name: "Jacobs",
            email: "haleyljacobs@gmail.com",
            role: 1,
            password: "password",
            password_confirmation: "password")

# Create teacher classes

dylans_class = FactoryBot.create(:klass, teacher_id: dylan.id)
kevins_class = FactoryBot.create(:klass, teacher_id: kevin.id)
haleys_class = FactoryBot.create(:klass, teacher_id: haley.id)

# Create dev student accounts

User.create(first_name: "Dylan",
  last_name: "Meskis",
  email: "dylanstudent@gmail.com",
  role: 0,
  password: "password",
  password_confirmation: "password")

User.create(first_name: "Kevin",
  last_name: "Simpson",
  email: "kevinstudent@gmail.com",
  role: 0,
  password: "password",
  password_confirmation: "password")

User.create(first_name: "Haley",
  last_name: "Jacobs",
  email: "haleystudent@gmail.com",
  role: 0,
  password: "password",
  password_confirmation: "password")

# Factory bot create users

100.times do
  FactoryBot.create(:user)
end

# Add users to teacher classes

users = User.all

users.sample(30).each do |user|
  dylans_class.users << user
end

users.sample(34).each do |user|
  kevins_class.users << user
end

users.sample(26).each do |user|
  haleys_class.users << user
end

# Add games to users
users.each do |user|
  rand(150).times do
    FactoryBot.create(:game, user_id: user.id)
  end
end