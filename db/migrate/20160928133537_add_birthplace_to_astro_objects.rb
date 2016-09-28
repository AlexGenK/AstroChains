class AddBirthplaceToAstroObjects < ActiveRecord::Migration
  def change
    add_column :astro_objects, :birthplace, :text
  end
end
