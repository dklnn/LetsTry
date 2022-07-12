class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc).page params[:page]
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

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
    @post = current_user.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    redirect_back fallback_location: user_path(current_user) if @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
