class CreateCalenders < ActiveRecord::Migration[5.2]
  def change
    create_table :calenders do |t|
      t.integer :user_id,null: false 
      t.integer :event_id,null: false 
      t.string :title,null: false 
      t.text :body
      t.boolean :disp_flag,null: false 
      t.datatime :start 
      t.datatime :end 
      t.string :allday
      
      t.timestamps
    end
  end
end
