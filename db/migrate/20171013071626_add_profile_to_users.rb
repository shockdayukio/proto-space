class AddProfileToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile, :string
    add_column :users, :works, :string
    add_column :users, :avatar, :string
  end
end
