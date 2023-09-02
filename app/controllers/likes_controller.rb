class LikesController < ApplicationController
  def index
    puts params
    Like.create(author: User.find_by(id: params['user_id']), post: Post.find_by(id: params['post_id']))
    redirect_to "/users/#{params['user_id']}/posts/#{params['post_id']}"
  end
end
