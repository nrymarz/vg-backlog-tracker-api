class UsersController < ApplicationController
    before_action :authorized, only: [:show]
    def show
        user = current_user
        render json:{user: user}

    end

    def login
        user = User.find_by(username: user_params[:username])
        render json: user
        if user && user.authenticate(user_params[:password])
            token = encode_token({user_id: user.id})
            render json: {user: user, jwt: token}
        else
            render json: {error:'invalid'}
        end
    end

    def create
        user = User.new(user_params)
        if user.save
            token = encode_token(user_id: user.id)
            render json: {user: user, jwt: token} 
        else
            render json: {error: 'invalid'}
        end
    end

    def update
    end

    private

    def user_params
        params.require(:user).permit(:username,:password,:backlog)
    end
end
