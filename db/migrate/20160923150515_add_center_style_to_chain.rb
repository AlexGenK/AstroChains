class AddCenterStyleToChain < ActiveRecord::Migration
  def change
    add_column :chains, :center_style, :text, default: "frame"
  end
end
