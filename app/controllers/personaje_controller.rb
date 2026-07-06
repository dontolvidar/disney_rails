class PersonajeController < ApplicationController
    
        include ActionController::HttpAuthentication::Token
        before_action :authenticate_user, only: [:index,:create, :destroy, :update]

    def index
       personajes=Personaje.all
       render json: PersonajeRepresenter.new(personajes).as_json_nombre_imagen, status: :ok
    end

    def create
	    personaje=Personaje.new(personaje_parametros)
        if personaje.save
            render json:personaje, status: :created
        else
            render json:personaje.errors, status: :unprocessable_entity
        end
    end

    def update
        personaje = Personaje.find(params[:id])
        if personaje.update(personaje_parametros)
            render json: personaje, status: :ok
        else
            render json: personaje.errors, status: :unprocessable_entity
        end
    end
    
    def destroy
        Personaje.find(params[:id]).destroy!
        head :no_content
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

    def personaje_parametros
        params.require(:personaje).permit(:nombre,:edad,:peso,:historia,:imagen)
    end

   
end
