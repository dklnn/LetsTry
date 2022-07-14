class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  # creates a comment with assigment post and current user
  def create
    @comment = @post.comments.create(comments_params.merge(user_id: current_user.id))
    redirect_back fallback_location: root_path if @comment.save!
  end

  def edit
    @comment = current_user.comments.find(params[:id])

    render :edit
  end

  # searching for current user's comment with received id. 
  # only user who created the comment can edit & update it
  def update
    @comment = current_user.comments.find(params[:id])

    if @comment.update(comments_params)
      redirect_to post_path(params[:post_id])
    else
      flash.now[:error] = 'Comment update failed'
      render :edit
    end
  end

  # if-else statement for checking two of approved conditions
  # 1. User can destroy the comment if user is post creator
  # 2. User can destroy the comment if user is comment creator
  def destroy
    @comment = if current_user.id == @post.user_id
                 @post.comments.find(params[:id])
               else
                 current_user.comments.find(params[:id])
               end
    redirect_back fallback_location: root_path if @comment.destroy
  end

  private

  # private before action that set's post to which the comment is attached 
  def set_post
    @post = Post.find(params[:post_id])
  end

  # list of permited params for comment creation & updating
  def comments_params
    params.require(:comment).permit(:body)
  end
end
