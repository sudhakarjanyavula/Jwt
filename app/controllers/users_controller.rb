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
    @user = @current_user
    @user.update(user_params) if @user
    render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
  end

  def show
    render json: @current_user
  end


  def destroy
     @current_user
     render json: []
  end



  private

  def user_params
    params.permit(:name, :username, :email, :password, :password_confirmation)
  end
end
