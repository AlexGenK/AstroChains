class AddDirectionToChain < ActiveRecord::Migration
  def change
    add_column :chains, :direction, :text
    add_column :chains, :visualization, :text
  end
end
