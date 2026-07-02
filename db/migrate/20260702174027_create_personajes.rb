class CreatePersonajes < ActiveRecord::Migration[8.1]
  def change
    create_table :personajes do |t|
      t.string :nombre
      t.integer :edad
      t.float :peso
      t.text :historia
      t.string :imagen

      t.timestamps
    end
  end
end
