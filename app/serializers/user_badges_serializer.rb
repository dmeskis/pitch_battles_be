class UserBadgesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name
  set_type :user
  attribute :badges do |obj|
    Rails.cache.fetch(obj.badge_cache_key(obj.badges)) do
      BadgeSerializer.new(obj.badges)
    end
  end


end
