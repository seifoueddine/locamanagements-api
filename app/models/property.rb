class Property < ApplicationRecord
  # attr_accessor :id, :label, :slug_id, :contact_id
  belongs_to :slug
  belongs_to :contact
  mount_uploaders :images, ImagesUploader
end
