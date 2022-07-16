class CommentsController < ApplicationController
  def new
    @user = User.find_by(id: params[:user_id])
    @post = Post.find_by(id: params[:post_id])
    @comment = @post.comments.new
  end

  def create
    @user = current_user
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.new(post_id: params[:post_id], author_id: current_user.id, text: comment_params[:text])

    if @comment.save
      @comment.update_comments_counter
      redirect_to user_post_path(@user.id, @post.id), notice: 'Comment created successfully!'
    else
      redirect_to user_post_path(@user.id, @post.id), notice: 'Sorry! something went wrong!'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
