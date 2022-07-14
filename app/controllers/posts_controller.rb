class PostsController < ApplicationController
	before_action :authorize_request
	

  def index
  	@posts = Post.all
  	render json: @posts
  end

    def create
  	#binding.pry
	  @post = @current_user.posts.new(post_params)
	  if @post.save
	  	render json: @post.as_json.merge({image: @post.image_url}), status: :created
	  else 
	  	render json: {error: @post.errors.full_messages},
	  				status: :unprocessable_entity
	  end
	end

	def show
		 @post = @current_user.posts
		 render json: @post
	end

	# def show
	#   @post = Post.find(params[:id])
	#   @comment = @post.comments.build
	# end


	def update
		binding.pry
		@post = @current_user.posts.find(params[:id])
		if @post.update(post_params)
			render json: @post, status: :ok
		else
			render json: {error: @post.errors.full_messages},
						status: :unprocessable_entity
		end
	end

	


	private

	def post_params
	  params.permit(:description, :image, :user_id)
	end
end
