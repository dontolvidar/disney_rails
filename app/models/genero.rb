class Genero < ApplicationRecord
    has_many :pelicula_generos
    has_many :peliculas, through: :pelicula_generos
end
