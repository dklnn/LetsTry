class LikesController < ApplicationController
  # create a like with assigment user, and params (see below)
  # else if like isn't saving then shows to the user full error message
  def create
    @like = current_user.likes.new(like_params)

    flash[:notice] = @like.errors.full_messages.to_sentence unless @like.save

    redirect_back fallback_location: root_path
  end

  # destroy choosed by :id like from user's like's table
  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy

    redirect_back fallback_location: root_path
  end

  private

  # list of permited params for like creation: 
  # likeable_type - can be in two statesment: 'Post' and 'Comment' (see polymophic preference in models)
  # likeable_id - id of relevant post or comment. Setted index to [id type] pair, thats excludes collision
  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type)
  end
end
