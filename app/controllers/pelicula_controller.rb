class PeliculaController < ApplicationController
    
        include ActionController::HttpAuthentication::Token
        before_action :authenticate_user, only: [:index,:show,:create,:update,:destroy]



    def index
        peliculas = Pelicula.all
        peliculas = peliculas.where(titulo: params[:titulo]) if params[:titulo].present?
        

        order = params[:order]&.downcase
        if order.in?(%w[asc desc])
            peliculas = peliculas.order(fecha_calificacion: order)
            
        end
        
        if params[:generos].present?
            peliculas = peliculas.joins(:generos).where(generos: { id: params[:generos] })
        end
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
    def update
        pelicula = Pelicula.find(params[:id])
        if pelicula.update(pelicula_parametros)
            render json: pelicula, status: :ok
        else
            render json: pelicula.errors, status: :unprocessable_entity
        end
    end
    def destroy
        Pelicula.find(params[:id]).destroy!
        head :no_content
    end
    

    def create
	    pelicula=Pelicula.new(pelicula_parametros)
        if pelicula.save
            render json:pelicula, status: :created
        else
            render json:pelicula.errors, status: :unprocessable_entity
        end
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