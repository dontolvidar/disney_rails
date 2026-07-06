class PeliculaController < ApplicationController
    
        include ActionController::HttpAuthentication::Token
        before_action :authenticate_user, only: [:index,:show]



    def index
        peliculas = Pelicula.all
        render json: PeliculaRepresenter.new(peliculas).as_json_sin_calificacion, status: :ok
    end

    def show
        pelicula = Pelicula.find(params[:id])
        personajes = pelicula.personajes

        render json: {
        pelicula: pelicula,
        personajes: PersonajeRepresenter.new(personajes).as_json_nombre
        }, status: :ok
    end

    private
    def authenticate_user
        # Authorization: Bearer <token>
        token, _options = token_and_options(request)
        user_id = AuthTokenService.decode(token)
        User.find(user_id)
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render status: :unauthorized
    end

    def pelicula_parametros
        params.require(:pelicula).permit(:titulo,:fecha_calificacion,:calificacion,:imagen)
    end
end