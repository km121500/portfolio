class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :user_id,null: false
      t.string :title,null: false
      t.text :body
      t.string :place
      t.string :date
      t.string :image_id,null: false
      t.timestamps
    end
  end
end
