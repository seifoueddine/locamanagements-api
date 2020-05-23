class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :name, :email, :created_at, :updated_at, :slug_id, :role, :avatar,
                            :theme_color, :language
  belongs_to :slug
end
