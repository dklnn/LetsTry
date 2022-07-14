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
  # so i broke woth this idea
  def follows
    @follows = @user.followees
  end

  def followers
    @follows = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
