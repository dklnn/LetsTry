class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(updated_at: :desc)
  end
end
