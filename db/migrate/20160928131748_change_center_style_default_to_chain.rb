class ChangeCenterStyleDefaultToChain < ActiveRecord::Migration
  def change
    change_column_default(:chains, :center_style, "elements")
  end
end
