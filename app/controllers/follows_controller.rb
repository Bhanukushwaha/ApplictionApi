class FollowsController < ApplicationController
  before_action :authorize_request!  
  def following
    ids = Follow.where(current_user_id:params[:user_id]).map(&:user_id)
    following = User.where(id:ids)
    render json: following, each_serializer: FollowSerializer, scope: current_user
  end

  def followers
    ids = Follow.where(user_id:params[:user_id]).map(&:current_user_id)
    followers = User.where(id:ids)
    render json: followers, each_serializer: FollowSerializer, scope: current_user
  end
  def unfollow
    @unfollow = Follow.find_by(user_id: params[:follow][:user_id] .to_i, current_user_id: current_user.id)
    if @unfollow.present?
      @unfollow.destroy
      return render json: {message: " unfollow is successfully"}
    else
      render json: { error: "This is not unfollows "}, status: :unprocessable_entity
    end
  end

	def create
		followers = Follow.find_by(user_id: params[:follow][:user_id].to_i, current_user_id: current_user.id)
    if followers.present?
      render json: { errors: "You have already followed this user" }
    else
      @follow = Follow.new(user_id: params[:follow][:user_id].to_i, current_user_id: current_user.id)
      if @follow.save
        render json: { message: "Your follow has been successfully created", follow: @follow }, status: :created
      else      
        render json: { error: @follow.errors }, status: :unprocessable_entity
      end
    end
	end
end
