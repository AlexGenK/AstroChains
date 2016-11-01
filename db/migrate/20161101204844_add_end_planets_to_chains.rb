class AddEndPlanetsToChains < ActiveRecord::Migration
  def change
    add_column :chains, :smn_retro, :boolean
    add_column :chains, :smn_weigth, :integer
    add_column :chains, :smn_center, :integer
    add_column :chains, :smn_relation, :integer
    add_column :chains, :smn_exist, :boolean
    add_column :chains, :nmn_retro, :boolean
    add_column :chains, :nmn_weigth, :integer
    add_column :chains, :nmn_center, :integer
    add_column :chains, :nmn_relation, :integer
    add_column :chains, :nmn_exist, :boolean
    add_column :chains, :chi_retro, :boolean
    add_column :chains, :chi_weigth, :integer
    add_column :chains, :chi_center, :integer
    add_column :chains, :chi_relation, :integer
    add_column :chains, :chi_exist, :boolean
    add_column :chains, :pro_retro, :boolean
    add_column :chains, :pro_weigth, :integer
    add_column :chains, :pro_center, :integer
    add_column :chains, :pro_relation, :integer
    add_column :chains, :pro_exist, :boolean
  end
end
