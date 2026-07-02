class PersonajeController < ApplicationController
    def index
        render json: Personaje.all
    end
    def create
	    personaje=Personaje.new(nombre: 'Mickey', edad: 50, peso: 69.2, historia: 'a golden globe candidate', imagen: 'http://imagen.com/Mickey')
        if personaje.save
            render json:personaje, status: :created
        else
            render json:personaje.errors, status: :unproccessable_entity
        end
    end
end
