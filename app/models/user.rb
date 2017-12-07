class User < ApplicationRecord
  has_many :prototypes
  has_many :likes
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
