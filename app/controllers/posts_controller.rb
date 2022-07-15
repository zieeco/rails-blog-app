class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments
    @likes = @post.likes
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)

    if @post.save
      @post.update_post_counter
      flash[:notice] = 'Your post was created successfully'
      redirect_to user_path(@user), notice: 'Your post was created successfully!'
    else
      flash[:alert] = 'sorry, something went wrong!'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
