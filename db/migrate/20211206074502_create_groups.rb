class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.string :image_id
      t.integer :owner_id, null: false
      t.timestamps
    end
  end
end
