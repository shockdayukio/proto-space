class CreatePrototypes < ActiveRecord::Migration[5.0]
  def change
    create_table :prototypes do |t|
      t.string :name, null: false, default: ""
      t.string :catch_copy, null: false, default: ""
      t.text :concept, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
