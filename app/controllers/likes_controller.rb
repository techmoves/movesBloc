class LikesController < ApplicationController
  def index
    puts params
    Like.create(author: User.find_by(id: params['user_id']), post: Post.find_by(id: params['post_id']))
    redirect_to "/users/#{params['user_id']}/posts/#{params['post_id']}"
  end

  def create
    @post = Post.find(params[:post_id])
     existing_like = Like.find_by(post: @post, author: current_user)

    if existing_like
      flash[:alert] = 'You have already liked this post.'
      
    @like = @current_user.likes.new(post_id: @post.id)

    respond_to do |format|
      format.html { redirect_to @post }
    end
  end
end
