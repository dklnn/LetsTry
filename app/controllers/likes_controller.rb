class LikesController < ApplicationController
  def new
    @like = current_user.likes.new
  end

  def create
    @like = current_user.likes.new(like_params)

    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save

    redirect_to post_path(params[:post_id])
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    # likeable = @like.likeable
    @like.destroy

    redirect_to post_path(params[:id])
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
