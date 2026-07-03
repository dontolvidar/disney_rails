class Personaje < ApplicationRecord
    has_many :pelicula_personajes
    has_many :peliculas, through: :pelicula_personajes
    validates :nombre, presence:true,length: {minimum:3}
end
