FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    role { 0}
    password { Faker::Internet.password }
    avatar { 1 }
    level_one_fastest_time { 0 }
    level_two_fastest_time { 0 }
    level_three_fastest_time { 0 }
    level_four_fastest_time { 0 }
    total_fastest_time { 0 }
    total_games_played { 0 }
  end
end
