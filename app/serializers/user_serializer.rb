class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name, :avatar, :role, :level_one_fastest_time, :level_two_fastest_time, :level_three_fastest_time, :level_four_fastest_time, :total_games_played
  attribute :games do |obj|
    GameSerializer.new(Game.where(user_id: obj.id))
  end
  attribute :badges do |obj|
    BadgeSerializer.new(obj.badges)
  end
  attribute :classes do |obj|
    KlassSerializer.new(obj.klasses)
  end
end
