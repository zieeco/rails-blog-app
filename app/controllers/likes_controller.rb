class LikesController < ApplicationController
  def create
    @like = Like.new(
      author_id: params[:user_id],
      post_id: params[:post_id]
    )

    if @like.save
      @like.update_likes_counter
      redirect_to user_post_likes_path, notice: 'Like added'
    else
      redirect_to user_post_likes_path, error: 'Sorry! something went wrong!'
    end
  end
end
