class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles
  end

  def show
    @article = Article.find(params[:id])
    render json: {data: @article, masege: "show articles sussefully"}
  end
  def like
    
  end
  def create
   @article = Article.new(user_params)
    if @article.save
      render json: @article, status: :created
    else
      render json: { errors: @article.errors.full_messages.join(", ") },
      status: :unprocessable_entity
    end
  end
  private
  def user_params
    params.require(:article).permit(:first_name, :last_name, :mobile_num, :user_id)
  end
end
