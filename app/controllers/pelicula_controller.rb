class PeliculaController < ApplicationController
    
        include ActionController::HttpAuthentication::Token
        before_action :authenticate_user, only: [:index]



    def index
        peliculas = Pelicula.all
        render json: PeliculaRepresenter.new(peliculas).as_json_sin_calificacion, status: :ok
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