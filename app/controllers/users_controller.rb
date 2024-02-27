class UsersController < ApplicationController
  before_action :authorize_request!, only: [:password_update]
  def create
    if (params[:user][:password] != params[:user][:confirmation_password])
      render json: {message: "Password and Conform Password does not match?" }, status: :unprocessable_entity
    else
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages.join(", ") },
        status: :unprocessable_entity
      end
    end
  end

  def password_update
    if params[:user][:password] == params[:user][:confirmation_password] 
      if @current_user.password == params[:user][:password]
        render json: { errors: "Plase enter new password"},
        status: :unprocessable_entity
      else
        @current_user.update(password: params[:user][:password])
        render json: { errors: "Your password is succssful updated" },
          status: :ok
      end
    else
      render json: { errors: "Password and Conform Password does not match?"},
        status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end

