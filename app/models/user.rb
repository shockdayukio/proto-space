class User < ApplicationRecord
  MINIMAM_NUMBER_OF_PASSWORD = 6
  MAXIMAM_NUMBER_OF_PASSWORD = 128

  has_many :prototypes
  has_many :likes
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  validates :avatar, :profile, :works, :occupation, :password, presence: true
  validates :name, :email, presence: true, uniqueness: true
  validates :password, length: { in: MINIMAM_NUMBER_OF_PASSWORD..MAXIMAM_NUMBER_OF_PASSWORD }
end
