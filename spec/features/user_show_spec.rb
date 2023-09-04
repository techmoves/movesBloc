require 'rails_helper'
RSpec.feature 'User Show page', type: :feature do
  before do
    # Creating the user
    @user = User.create(
      name: 'Phelelani',
      photo: 'https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&w=800',
      bio: 'I am a great programmer',
      posts_counter: 0
    )
    @first_post = Post.create(author: @user, title: 'Post One', text: 'This is my first post')
    @second_post = Post.create(author: @user, title: 'Post, two', text: 'This is my second post')
    @third_post = Post.create(author: @user, title: 'Post, three', text: 'This is my third post')
    @last_post = Post.create(author: @user, title: 'Post four', text: 'This is my fourth post')
    # Visiting the user's show page
    visit user_path(@user)
  end
  scenario "should show the user's profile picture" do
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end
  scenario "I can see the user's username" do
    expect(page).to have_content(@user.name)
  end
  scenario "I can see the user's bio" do
    expect(page).to have_content(@user.bio)
  end
end
RSpec.feature 'User Show page', type: :feature do
  before do
    # Creating the user
    @user = User.create(
      name: 'Phelelani',
      photo: 'https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&w=800',
      bio: 'I am a great programmer',
      posts_counter: 0
    )
    @first_post = Post.create(author: @user, title: 'Post One', text: 'This is my first post')
    @second_post = Post.create(author: @user, title: 'Post, two', text: 'This is my second post')
    @third_post = Post.create(author: @user, title: 'Post, three', text: 'This is my third post')
    @last_post = Post.create(author: @user, title: 'Post four', text: 'This is my fourth post')
    # Visiting the user's show page
    visit user_path(@user)
  end
  scenario "I can see a button that lets me view all of a user's posts" do
    expect(page).to have_button('See all posts')
  end
  scenario "When I click to see all posts, it redirects me to the user's post's index page" do
    click_link('See all posts')
    expect(page.current_path).to eq(user_posts_path(@user))
  end
  scenario "I can see the user's first 3 posts." do
    recent_posts = @user.recent_posts
    recent_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
      expect(page).to have_content("comments: #{post.comments_counter}")
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end
  end
end
