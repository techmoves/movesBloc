class CommentsController < ApplicationController
  def index; end

  def new
    @comment = self
  end

  def create
    @values = params[:comment]
    @comment = Comment.new(text: @values['text'], author: User.find_by(id: params['user_id']),
                           post: Post.find_by(id: params['post_id']))
    return unless @comment.save

    redirect_to "/users/#{params['user_id']}/posts/#{params['post_id']}"
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    if @comment.author == current_user
      if @comment.destroy
        flash[:success] = 'Comment deleted successfully.'
      else
        flash[:error] = 'Failed to delete the comment.'
      end
    else
      flash[:error] = "You don't have permission to delete this comment."
    end

    redirect_to user_post_path(params[:user_id], params[:post_id])
  end
end
