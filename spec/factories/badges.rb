FactoryBot.define do
  factory :badge do
    name { Faker::LeagueOfLegends.rank }
    description { Faker::LeagueOfLegends.quote }
  end
end
