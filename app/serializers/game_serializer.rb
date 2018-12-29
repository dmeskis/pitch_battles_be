class GameSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_duration, :level_one_duration, :level_two_duration, :level_three_duration, :level_four_duration, :level_one_perfect, :level_two_perfect, :level_three_perfect, :level_four_perfect, :all_perfect 
end
