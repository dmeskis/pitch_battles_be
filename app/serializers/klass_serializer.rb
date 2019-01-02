class KlassSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :class_key
end
