class PropertySerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :label, :created_at, :updated_at
  belongs_to :slug
  belongs_to :contact
end