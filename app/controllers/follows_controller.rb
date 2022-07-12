class FollowsController < ApplicationController
  before_action :set_user

  def create
    current_user.followees << @user
    redirect_back fallback_location: root_path
  end

  def destroy
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back fallback_location: root_path
  end

  # wanted to beatifuly hide 'followings' and 'followers' method into 'index', but thats required a lot of time
  def followings
    @follows = Follow.where(follower_id: params[:id])
    @follows = [] if @follows.nil?
  end

  def followers
    @follows = Follow.where(followee_id: params[:id])
    @follows = [] if @follows.nil?
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
