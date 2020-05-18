class Contract < ApplicationRecord
  validates_uniqueness_of :property_id
  belongs_to :slug
  belongs_to :user
  belongs_to :contact
  has_many :properties

  after_create do
    ContactsPropertiesStatsJob.perform_later 'new'
  end

  after_destroy do
    ContactsPropertiesStatsJob.perform_later 'delete'
  end
end
