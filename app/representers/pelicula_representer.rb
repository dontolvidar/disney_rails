class PeliculaRepresenter
  def initialize(peliculas)
    @peliculas = peliculas
  end

    def as_json
        @peliculas.map do |pelicula|
            {
                titulo: pelicula.titulo,
                fecha_calificacion: pelicula.fecha_calificacion,
                calificacion: pelicula.calificacion,
                imagen: pelicula.imagen
            }
        end
    end
end