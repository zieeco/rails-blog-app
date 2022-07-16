class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post_id: @post.id)

    if @like.save
      @like.update_likes_counter
      redirect_to user_post_likes_path, notice: 'Like added'
    else
      redirect_to user_post_likes_path, error: 'Sorry! something went wrong!'
    end
  end
end
