class KlassSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :class_key
end
