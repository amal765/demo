class Group < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :tasks
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  validates :max_members, presence: true,  numericality: { only_integer: true }
  validates :image, presence: true
end
