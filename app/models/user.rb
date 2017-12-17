class User < ApplicationRecord
  has_many :prototypes
  has_many :likes
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
end
