class UsersController < ApplicationController
    def index
        users = User.all
        render json: users
    end

    def show
        user = User.find_by(:username)
        render json: user
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render error
        end
    end

    def update
    end

    private

    def user_params
        params.require(:user).permit(:username,:password,:backlog)
    end
end
