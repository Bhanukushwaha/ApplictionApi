class ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token
  
  def authorize_request!
    if request.headers['Token'].present?
      header = request.headers['Token']
      header = header.split(' ').last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json: { errors: "you are not unauthorized && you token has been expired" },
        status: :unprocessable_entity
    end
  end
  
end
