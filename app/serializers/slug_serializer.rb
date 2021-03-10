class SlugSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :name , :created_at, :updated_at, :wilaya, :city, :subscription_type, :subscription_end, :logo
  has_many :properties
  has_many :users
end
