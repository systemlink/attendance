class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :times
      t.text :note

      t.timestamps null: false
    end
  end
end
