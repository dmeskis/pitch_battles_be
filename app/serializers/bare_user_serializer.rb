class BareUserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name, :avatar, :role, :level_one_fastest_time, :level_two_fastest_time, :level_three_fastest_time, :level_four_fastest_time, :total_games_played
end
