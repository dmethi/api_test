class CreateCages < ActiveRecord::Migration[6.1]
  def change
    create_table :cages do |t|
      t.integer :capacity
      t.boolean :state
      t.integer :num_dinos

      t.timestamps
    end
  end
end
