class UserBadgesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name
  set_type :user
  attribute :badges do |obj|
    BadgeSerializer.new(Badge.where(user_id: obj.id))
  end


end
