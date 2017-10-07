class Group < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :tasks
  mount_uploader :image, ImageUploader
  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  validates :max_members, presence: true,  numericality: { only_integer: true }



  private

    def image_size_validation
      if image.size > 1.megabytes
        errors.add(:base,"size should be less than 1Mb")
      end
    end

end
