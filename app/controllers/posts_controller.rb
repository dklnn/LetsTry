class PostsController < ApplicationController
  # shows all the posts three per page (pagination setting in model)
  # in order by descending of updated time
  def index
    @posts = Post.order(updated_at: :desc).page params[:page]
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  # creates the post with assigment to current user
  def create
    @post = current_user.posts.new(post_params)
    if @post.save!
      redirect_to post_path(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  # searching for current user's post with received id. 
  # only user who created the post can edit, update & destroy it
  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    redirect_to user_path(current_user) if @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
