require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Show view', type: :feature do
  before(:each) do
    @user = User.create(name: 'zieeco', photo: 'photo_link', bio: 'Programmer From Nigeria', email: 'test@yahoo.com',
                        password: '1234567890', confirmed_at: Time.now)

    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    (1..5).each do |i|
      @user.posts.create title: "Post #{i}", text: "This is my #{i} post!"
      @post.update_post_counter
    end
    @like = Like.create(author: @user, post_id: @post.id)
    visit new_user_session_path
    fill_in 'Email', with: 'test@yahoo.com'
    fill_in 'Password', with: '1234567890'
    click_button 'Log in'
    visit user_path @user.id
  end

  describe 'it test user#show' do
    it 'can see the username' do
      expect(page).to have_content 'zieeco'
    end

    it 'can see the image of all users' do
      expect(page.find('img')['src']).to have_content @user.photo
    end

    it 'can see the number of post the user has' do
      expect(page).to have_content 'Number of posts: 5'
    end

    it 'can see the user bio' do
      expect(page).to have_content 'Programmer From Nigeria'
    end

    it 'see the users first 3 posts' do
      expect(page).to have_content 'Post #1'
      expect(page).to have_content 'Post #2'
      expect(page).to have_content 'Post #3'
    end

    it 'has a button that let me see all posts' do
      expect(page.find('a', text: 'see all post')).to have_content 'see all post'
    end

    it 'When I click a users post, it redirects me to that post#show page' do
      visit user_posts_path(@user.id, @post.id)
      expect(current_path).to eq user_posts_path(@user.id, @post.id)
    end

    it 'When I click to see all posts, it redirects me to the users post#index page' do
      click_link('see all post')
      expect(current_path).to eq user_posts_path(@user.id)
    end
  end
end
# rubocop:enable Metrics/BlockLength
