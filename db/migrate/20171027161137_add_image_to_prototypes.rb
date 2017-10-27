class AddImageToPrototypes < ActiveRecord::Migration[5.0]
  def change
    add_column :prototypes, :image, :string
  end
end
