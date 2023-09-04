require 'rails_helper'

RSpec.feature 'User Show page', type: :feature do
  before do
    # Creating the user
    @user = User.create(name: 'Phelelani', photo: 'https://image.com/image.jpg', bio: 'Hello', posts_counter: 0)
    @first_post = Post.create(author: @user, title: 'Post One', text: 'First post', comments_counter: 0,
                              likes_counter: 0)
    @comment1 = Comment.create(author: @user, post: @first_post, text: 'comment 1')
    @comment2 = Comment.create(author: @user, post: @first_post, text: 'comment 2')
    # Visiting the user's show page
    visit user_posts_path(@user)
  end
  scenario "I can see the user's profile picture" do
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end
  scenario "I can see the user's username" do
    expect(page).to have_content(@user.name)
  end
  scenario "I can see the user's username" do
    expect(page).to have_content(@user.name)
  end
  scenario 'I can see the number of posts the user has written' do
    expect(page).to have_content('Number of posts: 1')
  end
  scenario "I can see a post's title" do
    expect(page).to have_content(@first_post.title)
  end
  scenario "I can see some of the post's body" do
    expect(page).to have_content(@first_post.text)
  end
  scenario 'I can see the first comments on a post.' do
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
  end
end
RSpec.feature 'User Show page', type: :feature do
  before do
    @user = User.create(name: 'Phelelani', photo: 'https://image.com/image.jpg', bio: 'Hello', posts_counter: 0)
    @first_post = Post.create(author: @user, title: 'Post One', text: 'First post', comments_counter: 0,
                              likes_counter: 0)
    @comment1 = Comment.create(author: @user, post: @first_post, text: 'comment 1')
    @comment2 = Comment.create(author: @user, post: @first_post, text: 'comment 2')
    # Visiting the user's show page
    visit user_posts_path(@user)
  end
  scenario 'I can see how many comments a post has' do
    expect(page).to have_content('comments: 2')
  end
  scenario 'I can see how many likes a post has' do
    expect(page).to have_content('Likes: 0')
  end
  scenario 'I can see a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_content('Pagination')
  end
end
