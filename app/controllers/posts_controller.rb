class PostsController < ApplicationController

  load_and_authorize_resource

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
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
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
