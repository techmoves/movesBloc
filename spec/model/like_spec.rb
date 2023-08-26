require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:user) { User.new(name: 'Tom', photo: 'https://example.com/tom.jpg', bio: 'Teacher from Mexico.', posts_counter: 0) }
  let(:post) { Post.new(author_id: user.id, title: 'Sample Post', comments_counter: 0, likes_counter: 0) }
  let(:like) { Like.new(author_id: user.id, post_id: post.id) }

  before { user.save! }
  before { post.save! }
  before { like.save! }
  it 'creating a like and not saving it will keep post likes counter as default' do
    expect(post.likes_counter).to eq(0)
  end

  it 'saving or creating a new like will trigger update_post_likes_counter automatically' do
    post.reload
    expect(post.likes_counter).to eq(1)
  end

describe '#update_likes_counter' do
    it 'increments the post likes_counter by 1' do
      user = User.create!(name: 'User Name', posts_counter: 0)
      post = Post.create!(author: user, title: 'Post Title', comments_counter: 0, likes_counter: 0)
      like = Like.new(author: user, post:)

      expect(post.likes_counter).to eq 0

      like.save!
      post.reload

      expect(post.likes_counter).to eq 1
    end
  end

end
