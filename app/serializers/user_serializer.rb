class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :first_name, :last_name
end
