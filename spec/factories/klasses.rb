FactoryBot.define do
  factory :klass do
    name { "Test Class" }
    teacher_id { FactoryBot.create(:user).id }
  end
end
