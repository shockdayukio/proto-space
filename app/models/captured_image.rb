class CapturedImage < ApplicationRecord
  belongs_to :prototype, inverse_of: :captured_images
  enum status: { main: 0, sub: 1 }

  mount_uploader :image, ImageUploader

  validate :only_one_main_image_per_prototype

  def only_one_main_image_per_prototype
    main_image = self.prototype.captured_images.main
    errors.add(:status, "Main Image for this Prototype has already exists.") if main_image.present?
  end
end

