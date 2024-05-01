class PostsController < ApplicationController
  before_action :authorize_request!, only: [:likes, :unlike, :create_comments]
  before_action :find_post,only: [:show,:update,:destroy,:likes, :unlike, :create_comments]
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
   render json: {data: @post}
  end

  def likes
    if Like.where(user_id:@current_user.id, likeable:params[:id].to_i, likeable_type:"Post").present?
      return render json: {message: "You have already like this post"}, status: :ok
    else
      @like = @post.likes.new
      @like.user_id = @current_user.id   
      if @like.save
        render json: {data: @like}
      else
        render json: {error: @like.errors}, status: :unprocessable_entity
      end
    end
  end
  def unlike
    @likes = @post.likes.where(user_id:@current_user.id)
    if @likes.present?
       @likes.destroy_all
      return render json: {message: "post unlike successfully"}
    else
      return render json: {error: "Like not found for this post"}, status: :not_found
    end
  end
  def create_comments
    @comment = @post.comments.new(comment_params)
    @comment.user_id = @current_user.id
    if @comment.save
      render json: {data: @comment}
    else
      return render json: {error: @comment.errors}, status: :unprocessable_entity
    end
  end
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages.join(", ") },
      status: :unprocessable_entity
    end
  end
  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: {masege: "post destroy sussefully"}
     else
      return render json: {error: @post.errors}, post: :unprocessable_entity
    end
  end
  private
  def find_post
    @post = Post.find_by(id: params[:id])
    if @post.nil?
     return render json: {error: "post not found"}, status: :not_found
    end
  end

  def comment_params
    params.require(:comment).permit(:title, :user_id, :post_id)
  end

  def post_params
    params.require(:post).permit(:title, :description, :user_id, :image)
  end
end
