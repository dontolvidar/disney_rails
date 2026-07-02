class PersonajeController < ApplicationController
    def index
        render json: Personaje.all
    end
end
