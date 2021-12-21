class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :title
      t.string :body
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
