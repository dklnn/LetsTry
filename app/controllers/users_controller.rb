class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.all.where(user_id: @user.id).order(created_at: :desc)
  end

  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    redirect_to posts_path
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_to posts_path
  end
end
