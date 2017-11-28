class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images, inverse_of: :prototype, dependent: :destroy
  accepts_nested_attributes_for :captured_images

  validates :name, :catch_copy, :concept ,presence: true

  def main_image
    self.captured_images.main.present? ? self.captured_images.main.first.image : 'no-image.png'
  end

  def sub_images
    self.captured_images.sub
  end
end
