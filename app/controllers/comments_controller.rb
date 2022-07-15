class CommentsController < ApplicationController
  def new
    @user = current_user
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(post_id: params[:post_id], author_id: params[:user_id], text: comment_params[:text])

    if @comment.save
      @comment.update_comments_counter
      redirect_to user_post_path(@user.id, params[:post_id]), notice: 'Comment created successfully!'
    else
      redirect_to user_post_path(current_user.id, params[:post_id]), notice: 'Sorry! something went wrong!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
