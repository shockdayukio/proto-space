class Prototype < ApplicationRecord
  belongs_to :user
  has_many :captured_images, inverse_of: :prototype, dependent: :destroy
  accepts_nested_attributes_for :captured_images
  has_many :likes
  has_many :comments

  acts_as_taggable

  validates :name, :catch_copy, :concept ,presence: true
  validate :no_more_than_three_tags
  validate :no_more_than_six_sub_images

  def no_more_than_three_tags
    if self.tag_list.count > NUMBER_OF_TAGS_IN_A_PROTOTYPE
      errors.add('tags', "cannot be contained more than #{NUMBER_OF_TAGS_IN_A_PROTOTYPE}")
    end
  end

  def no_more_than_six_sub_images
    if self.sub_images.count > MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE
      errors.add('sub_images', "cannot be contained more than #{MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE}")
    end
  end

  scope :newest_order, -> { order("created_at DESC") }
  scope :from_highest_count, -> { order("like_count DESC") }

  NUMBER_OF_DISPLAYED_PROTOTYPES = 8
  NUMBER_OF_SUB_IMAGES_IN_NEW_PROTOTYPE_FORM = 2
  MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE = 6
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
