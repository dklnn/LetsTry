class LikesController < ApplicationController
  before_action :set_likeable
  
  def new
    @like = current_user.likes.new
  end

  def index
    params.inspect
    @likes = Post.find(params[:post_id]).likes
  end

  def create
    @like = current_user.likes.new(like_params)

    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save

    redirect_back fallback_location: root_path
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    # likeable = @like.likeable
    @like.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_likeable
    if params.include?(:post)
      @likeable = Post.find(params[:post_id])
    end
  end

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
