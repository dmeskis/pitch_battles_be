class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name, :avatar, :role, :level_one_fastest_time, :level_two_fastest_time, :level_three_fastest_time, :level_four_fastest_time, :total_games_played
  attribute :games do |user|
    Rails.cache.fetch(user.game_cache_key(user.games)) do
      GameSerializer.new(user.games)
    end
  end
  attribute :badges do |user|
    Rails.cache.fetch(user.badge_cache_key(user.badges)) do
      BadgeSerializer.new(user.badges)
    end
  end
  attribute :class do |user|
    KlassSerializer.new(user.klass)
  end
end
