class CapturedImage < ApplicationRecord
  belongs_to :prototype, inverse_of: :captured_images
  enum status: { main: 0, sub: 1 }

  mount_uploader :image, ImageUploader
end
