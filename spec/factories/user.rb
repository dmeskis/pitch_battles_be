FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    role { 0}
    password { Faker::Internet.password }
    avatar { 1 }
    level_one_fastest_time { Faker::Number.number(6) }
    level_two_fastest_time { Faker::Number.number(6) }
    level_three_fastest_time { Faker::Number.number(6) }
    level_four_fastest_time { Faker::Number.number(6) }
    total_fastest_time { Faker::Number.number(6) }
    total_games_played { Faker::Number.number(2) }
  end
end
