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

  # wanted to beatifuly hide 'followings' and 'followers' method into 'index', but thats required a lot of time
  def followings
    @follows = current_user.follows.where(follower_id: params[:id])
    @follows = [] if @follows.nil?
  end

  def followers
    @follows = current_user.follows.where(followee_id: params[:id])
    @follows = [] if @follows.nil?
  end
end
