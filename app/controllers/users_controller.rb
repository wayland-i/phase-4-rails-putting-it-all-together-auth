class UsersController < ApplicationController
  skip_before_action :authorize, only: :create


  skip_before_action :authorize, only: :create

    #POST /users
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    #GET /users/:id
    def show
      render json: @current_user
    end

    private

    def user_params
      params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end

end
