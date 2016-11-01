class RemoveEndplanetsColumnsFromChains < ActiveRecord::Migration
  def change
    remove_column :chains, :end_planet, :integer
    remove_column :chains, :end_retro, :boolean
    remove_column :chains, :end_weigth, :integer
    remove_column :chains, :end_center, :integer
  end
end
