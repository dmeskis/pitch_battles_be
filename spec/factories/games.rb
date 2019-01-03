FactoryBot.define do
  factory :game do
    level_one_duration { Faker::Number.between(20000, 95000) }
    level_two_duration { Faker::Number.between(30000, 110000) }
    level_three_duration { Faker::Number.between(40000, 150000) }
    level_four_duration { Faker::Number.between(50000, 200000) }
    total_duration { level_one_duration + level_two_duration + level_three_duration + level_four_duration}
    user
  end
end
