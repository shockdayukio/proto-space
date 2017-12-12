class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images, inverse_of: :prototype, dependent: :destroy
  accepts_nested_attributes_for :captured_images
  has_many :likes
  has_many :comments

  validates :name, :catch_copy, :concept ,presence: true

  NUMBER_OF_DISPLAYED_PROTOTYPES = 8

  def main_image
    self.captured_images.main.present? ? self.captured_images.main.first.image : 'no-image.png'
  end

  def sub_images
    self.captured_images.sub
  end

  def created_by?(user)
    self.user == user
  end

  def liked_by?(user)
    return false unless user.present?
    self.likes.find_by(user_id: user.id).present?
  end

  def comment_num
    self.comments.size
  end
end
