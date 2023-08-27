require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'validates post_counter is an integer' do
      user = User.new(
        name: 'user1',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'test_bio',
        posts_counter: '!'
      )
      expect(user).to_not be_valid
    end

    it 'validates post_counter is greater than or equal to zero' do
      user = User.new(
        name: 'user1',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'test_bio',
        posts_counter: -1
      )
      expect(user).to_not be_valid
    end
  end

  describe 'test methods' do
    it 'shows the most recent 3 posts' do
      user = User.create(
        name: 'user1',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'test_bio',
        posts_counter: 1
      )

      # Create posts for the user
      posts = (1..5).map do |i|
        Post.create(
          author: user,
          title: "Post #{i}",
          text: "Text #{i}",
          likes_counter: 0,
          comments_counter: 0
        )
      end

      sorted_posts = posts.sort_by(&:created_at).reverse
      expected_posts = sorted_posts.first(3)

      expect(user.recent_posts).to eq(expected_posts)
    end
  end
end
