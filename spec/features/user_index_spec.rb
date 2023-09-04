require 'rails_helper'

RSpec.feature 'User index page', type: :feature do
  before do
    @user1 = User.create(name: 'Phelelani',
                         photo: 'https://image.com/image.jpg', bio: 'Text for Bio', posts_counter: 0)

    3.times do |i|
      Post.create(title: "Post #{i + 1}", author: @user1, comments_counter: 0, likes_counter: 0)
    end

    @user2 = User.create(name: 'nahid',
                         photo: 'https://www.istockphoto.com/photo.jpg', bio: 'Text for Bio', posts_counter: 0)
  end

  scenario 'I can see the username of all other users' do
    visit users_path

    expect(page).to have_content('Phelelani')
    expect(page).to have_content('nahid')
  end

  scenario 'I can see the profile picture for each user' do
    visit users_path

    expect(page).to have_css("img[src*='#{@user1.photo}']")
    expect(page).to have_css("img[src*='#{@user2.photo}']")
  end

  scenario 'I can see the number of posts each user has written' do
    visit users_path

    expect(page).to have_content('Number of posts: 3')
    expect(page).to have_content('Number of posts: 0')
  end

end
#it done and passed