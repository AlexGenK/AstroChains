class RemoveImageFromChain < ActiveRecord::Migration
  def change
    remove_column :chains, :image, :binary
    remove_column :chains, :code, :text
  end
end
