require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:user) { User.new(name: 'Tom', photo: 'https://example.com/tom.jpg', bio: 'Teacher from Mexico.', posts_counter: 0) }
  let(:post) { Post.new(author_id: user.id, title: 'Sample Post', comments_counter: 0, likes_counter: 0) }
  let(:comment) { Comment.new(author_id: user.id, post_id: post.id) }

  before { user.save! }
  before { post.save! }
  before { comment.save! }
  it 'creating a like and not saving it will keep post comments counter as default' do
    expect(post.comments_counter).to eq(0)
  end

  it 'saving or creating a new like will trigger update_post_comments_counter automatically' do
    post.reload
    expect(post.comments_counter).to eq(1)
  end

  describe '#update_comment_counter' do
    it 'increments the post comments_counter by 1' do
      user = User.create!(name: 'User Name', posts_counter: 0)
      post = Post.create!(author: user, title: 'Post Title', comments_counter: 0, likes_counter: 0)
      comment = Comment.new(author: user, post:, text: 'New comment')

      expect(post.comments_counter).to eq 0

      comment.save!
      post.reload

      expect(post.comments_counter).to eq 1
    end
  end
end
