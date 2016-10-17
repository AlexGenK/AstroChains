class AddEndToChains < ActiveRecord::Migration
  def change
    add_column :chains, :end_planet, :integer
    add_column :chains, :end_retro, :boolean
    add_column :chains, :end_weigth, :integer
    add_column :chains, :end_center, :integer
  end
end
