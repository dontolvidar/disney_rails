class PersonajeRepresenter
    def initialize(personajes)
        @personajes = personajes
    end

    def as_json
        @personajes.map do |personaje|
            {
                id: personaje.id,
                nombre: personaje.nombre,
                edad: personaje.edad,
                peso: personaje.peso,
                historia: personaje.historia,
                imagen: personaje.imagen
            }
        end
    end

    def as_json_nombre_imagen
        @personajes.map do |personaje|
            {
                nombre: personaje.nombre,
                imagen: personaje.imagen
            }
        end
    end

    private
    attr_reader :personajes
end