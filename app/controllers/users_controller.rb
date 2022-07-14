class UsersController < ApplicationController
  # show all the posts of choosed user and renders show template into view's folder
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(updated_at: :desc)
  end
end
