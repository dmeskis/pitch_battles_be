class GameSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_duration, :level_one_duration, :level_two_duration, :level_three_duration, :level_four_duration, :remaining_life
end
