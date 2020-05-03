class Contract < ApplicationRecord
  belongs_to :slug
  belongs_to :user
  belongs_to :contact
end
