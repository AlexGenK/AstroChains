class CreateAstroObjects < ActiveRecord::Migration
  def change
    create_table :astro_objects do |t|
      t.text :name
      t.date :date
      t.time :time
      t.text :comment

      t.timestamps null: false
    end
  end
end
