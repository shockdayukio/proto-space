class Like < ApplicationRecord
  belongs_to :prototype, counter_cache: :like_count
  belongs_to :user

  validates :prototype_id, uniqueness: { scope: :user_id }, presence: true, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: :prototype_id }, presence: true, numericality: { only_integer: true }
end
