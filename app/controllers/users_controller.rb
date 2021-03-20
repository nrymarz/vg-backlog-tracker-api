class UsersController < ApplicationController
    before_action :authorized, only: [:show, :update]
    def profile
        user = current_user
        render json: {
            user: user.username,
            backlog: user.backlog
        }
    end

    def login
        user = User.find_by(username: user_params[:username])
        if user && user.authenticate(user_params[:password])
            token = encode_token({user_id: user.id})
            render_user(user,token)
        else
            render json: {error:'Unable to Login'}, status: 400
        end
    end

    def create
        user = User.new(user_params)
        if user.save
            token = encode_token(user_id: user.id)
            render_user(user,token)
        else
            render json: {error: user.errors.full_messages[0]}, status: 400
        end
    end

    def update
        user = current_user
        user.update(backlog: user_params[:backlog])
        render json:{success: "updated successfully"}
    end

    def render_user(user,token)
        render json: {
            user: {
                username: user.username, 
                backlog: user.backlog
            },
            jwt: token
        }
    end

    private

    def user_params
        params.require(:user).permit(:username,:password,:backlog)
    end
end
