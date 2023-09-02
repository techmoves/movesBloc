class PostsController < ApplicationController
  def index
    @posts = User.find_by(id: params['user_id'])
  end

  def new
    @user = self
  end

  def show
    @user = User.find_by(id: params['user_id']).posts.find_by(id: params['id'])
    @comment = Comment.where(post_id: @posts)
    @comment = Comment.where(author_id: @user.id)
  end

  def create
    @values = params[:post]
    @post = Post.new(title: @values['title'], text: @values['text'], author: User.find_by(id: params['user_id']))
    return unless @post.save

    redirect_to "/users/#{params['user_id']}"
  end
end
