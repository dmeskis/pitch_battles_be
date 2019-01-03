FactoryBot.define do
  factory :game do
    level_one_duration { Faker::Number.between(20000, 95000) }
    level_two_duration { Faker::Number.between(30000, 110000) }
    level_three_duration { Faker::Number.between(40000, 150000) }
    level_four_duration { Faker::Number.between(50000, 200000) }
    level_one_perfect { [true, false].sample }
    level_two_perfect { [true, false].sample }
    level_three_perfect { [true, false].sample }
    level_four_perfect { [true, false].sample }
    all_perfect { [level_one_perfect, level_two_perfect, level_three_perfect, level_four_perfect].all? { |l| l == true} }
    total_duration { level_one_duration + level_two_duration + level_three_duration + level_four_duration}
    user
  end
end
