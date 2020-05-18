class Contact < ApplicationRecord
  has_many :properties
  belongs_to :slug
  has_many :appointments
  has_many :contracts

  after_create do
    ContactsPropertiesStatsJob.perform_later self
  end

  after_destroy do
    ContactsPropertiesStatsJob.perform_later 'delete'
  end
end
