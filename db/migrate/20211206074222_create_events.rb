class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :user_id,null: false
      t.string :title,null: false
      t.string :place
      t.text :body
<<<<<<< HEAD
=======
      t.string :place
>>>>>>> c1d8fd0e0c9b7631aa6c011bcd071df4616cc745
      t.string :date
      t.string :image_id,null: false
      t.timestamps
    end
  end
end
