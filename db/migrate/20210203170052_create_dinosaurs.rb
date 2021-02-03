class CreateDinosaurs < ActiveRecord::Migration[6.1]
  def change
    create_table :dinosaurs do |t|
      t.string :name
      t.string :species
      t.boolean :is_carnivore
      t.integer :cage

      t.timestamps
    end
  end
end
