class UsersController < ApplicationController
    before_action :authorize, only: [:show]

    def index
        render json: User.all
    end
    
    def create
        user = User.create!(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
end

    def show
        user = User.find_by(id: params[:id])
        render json: user
    end

    private

    def authorize 
        render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end

    def user_params
        params.permit(:username, :age, :address, :gender, :nationality, :occupation, :password)
    end
end
