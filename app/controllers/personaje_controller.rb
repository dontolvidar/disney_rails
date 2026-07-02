class PersonajeController < ApplicationController
    def index
        render json: Personaje.all
    end
    def create
	    personaje=Personaje.new(personaje_parametros)
        if personaje.save
            render json:personaje, status: :created
        else
            render json:personaje.errors, status: :unprocessable_entity
        end
    end
    
    private
    def personaje_parametros
        params.require(:personaje).permit(:nombre,:edad,:peso,:historia,:imagen)
    end
end
