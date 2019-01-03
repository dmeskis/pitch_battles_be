class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name, :avatar, :role, :level_one_fastest_time, :level_two_fastest_time, :level_three_fastest_time, :level_four_fastest_time, :total_games_played
  attribute :games do |obj|
    Rails.cache.fetch(obj.game_cache_key(obj.games)) do
      GameSerializer.new(Game.where(user_id: obj.id))
    end
  end
  attribute :badges do |obj|
    Rails.cache.fetch(obj.badge_cache_key(obj.badges)) do
      BadgeSerializer.new(obj.badges)
    end
  end
  attribute :class do |obj|
    KlassSerializer.new(obj.klass)
  end
end
