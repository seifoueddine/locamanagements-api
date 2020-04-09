class ContactSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :name, :email, :first_phone, :second_phone , :created_at, :updated_at
  has_many :properties
end
