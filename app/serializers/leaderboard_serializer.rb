class LeaderboardSerializer
  include FastJsonapi::ObjectSerializer
  attributes :first_name, :last_name
  set_type :user
  
  attribute :highscore do |user, params|
    case params[:level]
    when 'level_one'
      user.level_one_fastest_time
    when 'level_two'
      user.level_two_fastest_time
    when 'level_three'
      user.level_three_fastest_time
    when 'level_four'
      user.level_four_fastest_time
    when 'overall'
      user.total_fastest_time
    end
  end

end
