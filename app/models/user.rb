class User < ApplicationRecord
  has_and_belongs_to_many :groups
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :picture, PictureUploader
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :phone_number, presence: true, length: {minimum: 10}
  def admin?
    if self.role_id == 1
      true
    else
      false
    end
  end

  def full_name
    [first_name, last_name].join(" ")
  end

end
