class CreatePeliculaPersonajes < ActiveRecord::Migration[8.1]
  def change
    create_table :pelicula_personajes do |t|
      t.references :personaje, null: false, foreign_key: true
      t.references :pelicula, null: false, foreign_key: true

      t.timestamps
    end
  end
end
