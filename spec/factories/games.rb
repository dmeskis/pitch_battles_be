FactoryBot.define do
  factory :game do
    total_duration { Faker::Number.number(5) }
    level_one_duration { Faker::Number.number(5) }
    level_two_duration { Faker::Number.number(5) }
    level_three_duration { Faker::Number.number(5) }
    level_four_duration { Faker::Number.number(5) }
    remaining_life { Faker::Number.between(0, 3) }
    user
  end
end
