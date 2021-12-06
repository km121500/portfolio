class CreateEventPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :event_places do |t|
      t.integer :event_id,null: false 
      t.integer :place,null: false
      t.timestamps
    end
  end
end
