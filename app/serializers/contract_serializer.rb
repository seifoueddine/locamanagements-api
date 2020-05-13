class ContractSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes :contract_type, :contract_details,
             :payment_frequency_number, :payment_frequency_name,
             :payment_date, :start_date, :end_date, :property_id,
             :user_id, :contact_id, :slug_id,:payment_periods
  belongs_to :user
  belongs_to :contact
  has_many :properties
end
