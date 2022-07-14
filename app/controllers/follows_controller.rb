class FollowsController < ApplicationController
  before_action :set_user

  # includes @user that choose current user into current user's followed_user's table
  # and includes current user into @user followers table
  def create
    current_user.followees << @user
    redirect_back fallback_location: root_path
  end

  # deletes @user that choose current user into current user's followed_users table
  def destroy
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back fallback_location: root_path
  end

  # wanted to beatifuly hide 'followings' and 'followers' method into 'index', 
  # but thats required a lot of time so i broke woth this idea

  # list of people the user is following
  def follows
    @follows = @user.followees
  end

  # list of people that follows the user
  def followers
    @follows = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
