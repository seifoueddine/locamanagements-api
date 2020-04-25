class Appointment < ApplicationRecord
  belongs_to :slug
  belongs_to :user
  belongs_to :property
  belongs_to :contact
end
