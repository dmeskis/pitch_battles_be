class UserGamesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name
  set_type :user
  attribute :games do |user|
    Rails.cache.fetch(user.game_cache_key(user.games)) do
      GameSerializer.new(user.games)
    end
  end


end
