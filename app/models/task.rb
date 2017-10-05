class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group
  validates :name, presence: true, length: {maximum: 50}
  validates :duration, presence: true, numericality: true
  def completed?
    if status
      true
    else
      false
    end
  end
end
