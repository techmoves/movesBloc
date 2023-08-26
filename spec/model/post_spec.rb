require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create(
      name: 'test user',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'test_bio',
      posts_counter: 1
    )
  end

  let(:post) do
    Post.create(
      author: user,
      title: 'Hello',
      text: 'This is my test post'
    )
  end

  describe 'validations in Post' do
    it 'validates title presence' do
      post.title = nil
      expect(post).to_not be_valid
    end

    it 'validates title length not exceeding 250 characters' do
      post.title = 'a' * 251
      expect(post).to_not be_valid
    end

    it 'validates comments counter is numeric' do
      post.comments_counter = 'not-numeric'
      expect(post).to_not be_valid
    end

    it 'validates likes counter is numeric' do
      post.likes_counter = 'not-numeric'
      expect(post).to_not be_valid
    end

    it 'validates likes counter is equal or greater than zero' do
      post.likes_counter = -1
      expect(post).to_not be_valid
    end

    it 'validates comments counter is equal or greater than zero' do
      post.comments_counter = -1
      expect(post).to_not be_valid
    end
  end

  describe 'methods in Post' do
    it 'updates user post count' do
      expect { post.send(:update_user_posts_counter) }.to change { user.posts_counter }.by(-1)
    end

    it 'get recent 5 comments' do
      expect(post.recent_comments).to eq(post.comments.last(5))
      puts post.comments.last(5)
    end
  end
end
