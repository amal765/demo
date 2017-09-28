class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  def completed?
    if status
      true
    else
      false
    end
  end
end
