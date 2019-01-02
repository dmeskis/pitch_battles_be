class ClassDashboardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :class_key
  attribute :teacher do |klass|
    klass.teacher
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
  
end
