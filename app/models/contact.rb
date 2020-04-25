class Contact < ApplicationRecord
  has_many :properties
  belongs_to :slug
  has_many :appointments
end
