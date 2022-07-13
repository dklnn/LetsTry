class CommentsController < ApplicationController
  def create
    @comment = set_post.comments.create(comments_params.merge(user_id: current_user.id))
    redirect_back fallback_location: root_path if @comment.save!
  end

  def edit
    @comment = Comment.find(params[:id])

    render :edit
  end

  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comments_params)
      redirect_to post_path(params[:post_id])
    else
      flash.now[:error] = 'Comment update failed'
      render :edit
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    redirect_back fallback_location: root_path if @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comments_params
    params.require(:comment).permit(:body)
  end
end
