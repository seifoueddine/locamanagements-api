class PropertySerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :label, :created_at, :updated_at, :images, :contact_id,
             :property_type, :surface, :address, :wilaya, :city, :owner_price,
             :agency_price, :transaction_type, :nbr_of_pieces,
             :is_furnished, :is_equipped, :has_elevator, :has_floors,
             :floor, :has_garage, :has_garden, :has_swimming_pool,
             :has_sanitary, :description
  # belongs_to :slug
  belongs_to :contact
end
