class CommentsController < ApplicationController
	before_action :authorize_request

  def index
    #binding.pry
    @comments = Comment.includes(:commentable).all
    render json: @comments.count
  end

  def create
    #binding.pry
    @post = @current_user.posts.find_by(params[:id])
  	@comment = @post.comments.new(comment_params)
  	@comment.user_id = @current_user.id
  	if @comment.save
  		render json: @comment, status: :created
  	else
  		render json: { errors: @comment.errors.full_messages },
             status: :unprocessable_entity
    end 		
  end


  def show
    @comments = Comment.includes(:commentable).all
    render json: @comments
  end

  def update
   binding.pry
    @post = Post.find_by(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @b = @comment.update(comment_params)
    if @b
    render json: @b, status: :ok
    else
      render json: { errors: @a.errors.full_messages },
             status: :unprocessable_entity
    end
  end


  def destroy
  # binding.pry
    @post = Post.find_by(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    render json: {message: "Destroy"}
  end


  private

  def comment_params
  	params.permit(:body, :user_id, :post_id)
  end
end
