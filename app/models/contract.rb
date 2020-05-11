class Contract < ApplicationRecord
  validates_uniqueness_of :property_id
  belongs_to :slug
  belongs_to :user
  belongs_to :contact
  has_many :properties
end
