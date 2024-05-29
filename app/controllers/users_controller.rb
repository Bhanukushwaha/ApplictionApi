class UsersController < ApplicationController
  before_action :authorize_request!, only: [:index, :password_update, :profile]
  def index
    @users = User.where.not(id: current_user.id)
    render json: @users
  end
 
  def profile    
    @project = current_user
    render json: @project
  end
   def show
    @user = User.find_by(id: params[:id])
    render json: @user, root: "data", each_serializer: UserSerializer 
    # render json: {data: @user}
   end
  def create
    if (params[:user][:password] != params[:user][:confirmation_password])
      render json: {message: "Password and Conform Password does not match?" }, status: :unprocessable_entity
    else
      @user = User.new(user_params)
      if @user.save
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), user: @user}, status: :ok
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
    params.require(:user).permit(:email, :password, :name)
  end
end

