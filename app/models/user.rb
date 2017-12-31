class User < ApplicationRecord
  has_many :prototypes
  has_many :likes
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates :name, :profile, :works, :occupation, :password, :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
end
