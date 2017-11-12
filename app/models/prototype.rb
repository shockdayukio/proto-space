class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images, inverse_of: :prototype
  accepts_nested_attributes_for :captured_images

  validates :name, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
end
