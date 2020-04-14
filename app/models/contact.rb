class Contact < ApplicationRecord
  has_many :properties
  belongs_to :slug
end
