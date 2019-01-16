class UserBadgesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name
  set_type :user
  attribute :badges do |user|
    Rails.cache.fetch(user.badge_cache_key(user.badges)) do
      BadgeSerializer.new(user.badges)
    end
  end


end
