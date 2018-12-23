class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name
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
