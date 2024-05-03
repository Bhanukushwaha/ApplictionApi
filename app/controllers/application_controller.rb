class ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token
  helper_method :current_user
  def current_user
    if request.headers['Token'].present?
      header = request.headers['Token']
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      @current_user = nil
    end
  end

  def authorize_request!
    return render json: { errors: "you are not unauthorized && you token has been expired" },status: :unprocessable_entity unless current_user.present?
  end  
end
