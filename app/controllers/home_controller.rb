class HomeController < ApplicationController
  before_action :authorize_request!
  def index
    @user = User.all
    if @user.present?
      render json: @user, status: :ok
    else
     render json: { errors: "user not found" },
        status: :unprocessable_entity
    end 
  end
end
