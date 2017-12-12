class Comment < ApplicationRecord
  belongs_to :prototype
  belongs_to :user

  validates :text, presence: true
  validates :prototype_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
end
