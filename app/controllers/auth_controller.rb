class AuthController < ApplicationController
    class AuthenticationError < StandardError; end
    rescue_from ActionController::ParameterMissing, with: :parameter_missing
    rescue_from AuthenticationError, with: :handle_authenticated

    def create
        user = User.find_by(username: params.require(:username))

        raise AuthenticationError unless user && user.authenticate(params.require(:password))
        token= AuthTokenService.call (user.id)

        render json: {token: token}, status: :created
    end
    private
    def user
        @user ||= User.find_by(username: params.require(:username))
    end

    def parameter_missing(e)
        render json: {errores:e.record.errors} , status: :unprocessable_entity
    end

    def handle_authenticated(e)
        head: unauthorized
    end
end
