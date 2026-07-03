class AuthController < ApplicationController
    rescue_from ActiveRecord::RecordNotDestroyed, with: :parameter_missing
    
    def create
	    p params.require(:username).inspect
        p params.require(:password).inspect
        render json: {token: "123"}, status: :created
    end
    private
    def parameter_missing(e)
        render json: {errores:e.record.errors} , status: :unprocessable_entity
    end

   
end