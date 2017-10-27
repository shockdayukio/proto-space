class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images
  mount_uploader :image, ImageUploader
end
