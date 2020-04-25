class AppointmentSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :label, :created_at, :updated_at, :contact_id, :user_id,
             :status, :description, :property_id, :contact_id, :service, :start_time
  belongs_to :user
  belongs_to :property
  belongs_to :contact
end
