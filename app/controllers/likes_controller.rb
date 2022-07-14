class LikesController < ApplicationController
	before_action :authorize_request
	
	def index
		@likes = Like.includes(:likeable).all
		render json: @likes.count
	end


	def create
		@like = @current_user.likes.new(like_params) 
		@like.user_id = @current_user.id
		#binding.pry
		if @like.save
			render json: @like, status: :created
    	else
      		render json: { errors: @like.errors.full_messages },
             status: :unprocessable_entity
    	end
	end

	def destroy
		binding.pry
		@like = @current_user.likes.find(params[:id])
		likeable = @like.likeable
		@like.destroy
		render json: post, status: :destroy
	end

	def show
		@likes = Like.includes(:likeable).all
		render json: @likes
	end

	private
	def like_params
		params.permit(:likeable_id, :likeable_type)
	end
end
