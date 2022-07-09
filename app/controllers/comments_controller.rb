class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comments_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comment.save
    redirect_to post_path(@post)
  end

  def show 
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])

    render :edit
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(comments_params)
      redirect_to post_path(@post)
    else
      flash.now[:error] = "Comment update failed"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comments_params
    params.require(:comment).permit(:body)
  end
end
