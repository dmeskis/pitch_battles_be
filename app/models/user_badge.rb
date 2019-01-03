class UserBadge < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :badge
end