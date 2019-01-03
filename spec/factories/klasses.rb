FactoryBot.define do
  factory :klass do
    name { "#{Faker::Name.name}'s Class" }
    teacher_id { FactoryBot.create(:user).id }
  end
end
