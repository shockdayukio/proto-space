class CreateCapturedImages < ActiveRecord::Migration[5.0]
  def change
    create_table :captured_images do |t|
      t.string :image, null: false, default: ""
      t.integer :status, null: false
      t.references :prototype, foreign_key: true
      t.timestamps
    end
  end
end
