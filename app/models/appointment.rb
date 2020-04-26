class Appointment < ApplicationRecord
  validates_uniqueness_of :start_time
  belongs_to :slug
  belongs_to :user
  belongs_to :property
  belongs_to :contact
end
