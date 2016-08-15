class CreateChains < ActiveRecord::Migration
  def change
    create_table :chains do |t|
      t.text :type
      t.text :code
      t.binary :image
      t.text :comment
      t.references :astro_object, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
