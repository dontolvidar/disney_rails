class Pelicula < ApplicationRecord
    has_many :pelicula_personajes
    has_many :personajes, through: :pelicula_personajes

    has_many :pelicula_generos
    has_many :generos, through: :pelicula_generos

end
