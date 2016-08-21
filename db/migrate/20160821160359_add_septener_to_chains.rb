class AddSeptenerToChains < ActiveRecord::Migration
  def change
    add_column :chains, :septener, :boolean, :default=>false
  end
end
