class Slug < ApplicationRecord
  validates_uniqueness_of :name
  mount_uploader :logo, LogoUploader
  has_many :users, dependent: :destroy
  has_many :properties, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :contracts, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
