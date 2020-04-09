class SlugSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :name , :created_at, :updated_at
  has_many :properties
end
