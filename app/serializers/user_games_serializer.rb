class UserGamesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name
  set_type :user
  attribute :games do |obj|
    Rails.cache.fetch(obj.game_cache_key(obj.games)) do
      GameSerializer.new(Game.where(user_id: obj.id))
    end
  end


end
