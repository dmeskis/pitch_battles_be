class BadgeSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
end
