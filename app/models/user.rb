class User < ApplicationRecord
  has_many :prototypes
  has_many :likes
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates :avatar, :profile, :works, :occupation, :password, presence: true
  validates :name, :email, presence: true, uniqueness: true
  validates :password, length: { in: 6..128 }
end
