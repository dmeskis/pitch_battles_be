class GameSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
end
