class TeacherDashboardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :class_key
  attribute :teacher do |klass|
    BareUserSerializer.new(klass.teacher)
  end

  attribute :students do |klass|
   UserSerializer.new(klass.users)
  end

  attribute :level_one_fastest_time do |klass|
    klass.level_one_fastest_time
  end

  attribute :level_two_fastest_time do |klass|
    klass.level_two_fastest_time
  end

  attribute :level_three_fastest_time do |klass|
    klass.level_three_fastest_time
  end

  attribute :level_four_fastest_time do |klass|
    klass.level_four_fastest_time
  end

  attribute :overall_fastest_time do |klass|
    klass.overall_fastest_time
  end

  attribute :most_games do |klass|
    klass.most_games
  end

  attribute :most_badges do |klass|
    klass.most_badges
  end
end
