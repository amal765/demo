class Group < ApplicationRecord
  has_and_belongs_to_many :users
  mount_uploader :image, ImageUploader
end
