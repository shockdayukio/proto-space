class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images, inverse_of: :prototype, dependent: :destroy
  accepts_nested_attributes_for :captured_images

  validates :name, :catch_copy, :concept ,presence: true
end
