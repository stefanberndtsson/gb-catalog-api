class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.text :title
      t.text :note

      t.timestamps
    end
  end
end
