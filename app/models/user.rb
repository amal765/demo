class User < ApplicationRecord
  has_and_belongs_to_many :groups
  has_many :tasks
  belongs_to :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :picture, PictureUploader
  validates :first_name, presence: true, length: {maximum: 50}, on: :update
  validates :last_name, presence: true, length: {maximum: 50}, on: :update
  validates :phone_number, presence: true, length: {minimum: 10}, on: :update

  validates :password, presence: true, length: { minimum: 6 }, on: :update
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
                      validates :email,presence: true, length: {maximum: 255},
                      format: {with: VALID_EMAIL_REGEX},
                       uniqueness: {case_sensitive: false}, on: :create

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

  def activated?
    if first_name
      true
    else
      false
    end
  end

  protected

    def password_required?
      false
    end

    def email_required?
      true
    end
end
