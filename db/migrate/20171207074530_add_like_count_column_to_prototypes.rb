class AddLikeCountColumnToPrototypes < ActiveRecord::Migration[5.0]
  def change
    add_column :prototypes, :like_count, :integer, null: false, default: 0
  end
end
