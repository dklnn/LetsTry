class FollowsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.followees << @user
    redirect_to posts_path
  end

  def destroy
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to posts_path
  end

  def followings
    @follows = Follow.all.where(follower_id: params[:id])
    @follows = [] if @follows.nil?
  end

  def followers
    @follows = Follow.all.where(followee_id: params[:id])
    @follows = [] if @follows.nil?
  end
end
