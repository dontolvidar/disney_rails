class AuthController < ApplicationController
    class AuthenticationError < StandardError; end
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from AuthenticationError, with: :handle_authenticated



    def login
        user = User.find_by(username: params.require(:username))
        raise AuthenticationError unless user&.authenticate(params.require(:password))
        token= AuthTokenService.call (user.id)
        render json: {token: token}, status: :ok
    rescue ActionController::ParameterMissing => e
        render json: {errores:e.record.errors} , status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
    rescue JWT::DecodeError
        render status: :unauthorized
    rescue AuthenticationError
        render status: :unauthorized
        
    end
    
    
    
    def create
        user = User.new(username: params.require(:username), password: params.require(:password), email: params.require(:email))
        if User.exists?(username: user.username)
            
            render json: {errores:"El usuario ya existe"} , status: :unprocessable_entity

            return
        else
            active_record = user.save
            if active_record
            UserNotifierMailer.send_signup_email(user).deliver_now
            token= AuthTokenService.call (user.id)
            render json: {creado:"El usuario se ha creado correctamente"} , status: :created
            else
                render json: user.errors, status: :unprocessable_entity
            end
        end

        
        
        rescue ActionController::ParameterMissing => e
            render json: {errores:e.record.errors} , status: :unprocessable_entity
        rescue ActiveRecord::RecordNotFound
            render status: :unauthorized
        rescue JWT::DecodeError
            render status: :unauthorized
        rescue AuthenticationError
            render status: :unauthorized
    end

    
    private
    def user
        @user ||= User.find_by(username: params.require(:username))
    end

    def parameter_missing(e)
        render json: {errores:e.record.errors} , status: :unprocessable_entity
    end

    def handle_authenticated
        head :unauthorized
    end
end
