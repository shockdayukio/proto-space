class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images, inverse_of: :prototype, dependent: :destroy
  accepts_nested_attributes_for :captured_images
  has_many :likes
  has_many :comments

  acts_as_taggable

  validates :name, :catch_copy, :concept ,presence: true

  scope :newest_order, -> { order("created_at DESC") }
  scope :from_highest_count, -> { order("like_count DESC") }

  NUMBER_OF_DISPLAYED_PROTOTYPES = 8

  NUMBER_OF_TAGS_IN_A_PROTOTYPE = 3

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

  def created_at
    self['created_at'].to_s(:date)
  end
end
