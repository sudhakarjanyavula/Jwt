class RelationshipsController < ApplicationController
	before_action :authorize_request

  def create
    @user = User.find(params[:followed_id])
    @current_user.follow(@user)
    # redirect_to @user
    render :json => {message: "Done"}
  end

  def destroy
    #binding.pry
    @user = Relationship.find(params[:id]).followed
    @current_user.unfollow(@user)
    render :json => {message: "unfollow"}
  end
end
