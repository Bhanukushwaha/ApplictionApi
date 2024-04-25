class AuthenticationController < ApplicationController
  def login
    @user = User.find_by(email: params[:user][:email])
    if @user&.authenticate(params[:user][:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M")
     }, status: :ok
    else
      render json: { error: 'Email and password incorrect' }, status: :unauthorized
    end
  end
end