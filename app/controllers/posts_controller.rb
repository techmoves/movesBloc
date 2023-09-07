class PostsController < ApplicationController
  before_action :authenticate_user!

  load_and_authorize_resource

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  def index
    @posts = User.includes(:posts, :comments).find_by(id: params['user_id'])
  end

  def new
    @user = self
    @current_user = current_user
  end

  def show
    @user = User.find_by(id: params['user_id']).posts.find_by(id: params['id'])
    @comment = Comment.includes(:author).where(post_id: @posts)

    @posts = User.find_by(id: params['user_id']).posts.find_by(id: params['id'])
  end

  def create
    @post = @current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post }
      else
        format.html { render :new }
      end
    end
     def destroy
      @post = Post.find(params[:id])
      authorize! :destroy, @post

      if @post.destroy
        flash[:success] = 'Post deleted successfully.'
      else
        flash[:error] = "You don't have permission to delete this post."
      end
    end
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
