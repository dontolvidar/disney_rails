class PeliculaGenero < ApplicationRecord
  belongs_to :pelicula
  belongs_to :genero
end
