class UsersController < ApplicationController
	before_action :authorize_request, except: :create
  
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end


   def index
    @user = @current_user
    render json: @user, status: :ok
  end

  def update
    #binding.pry
    @user = @current_user
    @a = @user.update(user_params)
    if @a
      render json: @a, status: :ok
    else
      render json: { errors: @a.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def show
    render json: @current_user
  end


  def destroy
     @current_user
     render json: []
  end

  def following
   # @title = "Following"
    @user  = @current_user
    @users = @user.following
    if @users
      render json: @users, status: :ok
    else
      render json: { errors: @users.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def followers
  # @title = "Followers"
    @user  = @current_user
    @users = @user.followers
    if @users
      render json: @users
    else
      render json: { errors: @users.errors.full_messages },
             status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.permit(:name, :username, :email, :password, :website, :bio, :phone, :gender)
  end
end
