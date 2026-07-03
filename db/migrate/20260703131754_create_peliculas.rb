class CreatePeliculas < ActiveRecord::Migration[8.1]
  def change
    create_table :peliculas do |t|
      t.string :titulo
      t.integer :edad
      t.date :fecha_calificacion
      t.integer :calificacion
      t.string :imagen

      t.timestamps
    end
  end
end
