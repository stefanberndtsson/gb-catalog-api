class CreateCartridges < ActiveRecord::Migration
  def change
    create_table :cartridges do |t|
      t.integer :game_id
      t.text :case
      t.text :code
      t.text :note

      t.timestamps
    end
  end
end
