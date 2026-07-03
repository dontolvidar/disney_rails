class CreatePeliculaGeneros < ActiveRecord::Migration[8.1]
  def change
    create_table :pelicula_generos do |t|
      t.references :pelicula, null: false, foreign_key: true
      t.references :genero, null: false, foreign_key: true

      t.timestamps
    end
  end
end
