class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :chains, :type, :kind
  end
end
