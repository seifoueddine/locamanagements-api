class ContractSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel
  attributes
  belongs_to :user
  belongs_to :contact
end
