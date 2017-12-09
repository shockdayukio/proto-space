class AddIndexToLikesPrototypeIdAndUserId < ActiveRecord::Migration[5.0]
  def change
    add_index :likes, [ :prototype_id, :user_id ], unique: true
  end
end
