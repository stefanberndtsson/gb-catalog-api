class RenameCartridgeColumnCaseToCasing < ActiveRecord::Migration
  def change
    rename_column :cartridges, :case, :casing
  end
end
