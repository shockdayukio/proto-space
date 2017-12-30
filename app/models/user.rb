class User < ApplicationRecord
  has_many :prototypes
  has_many :likes
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates :email, :name, :profile, :works, :occupation, :password, :password_confirmation, presence: true
end
