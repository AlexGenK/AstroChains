class AddPointsToAstroObjects < ActiveRecord::Migration
  def change
    add_column :astro_objects, :points, :text
  end
end
