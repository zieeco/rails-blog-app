require 'rails_helper'

RSpec.feature 'User index', type: :feature do
  before(:each) do
    @user = User.create(name: 'zieeco', photo: 'photo_link', bio: 'Programmer From Nigeria', email: 'test@yahoo.com',
                        password: '1234567890', confirmed_at: Time.now)
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    @like = Like.create(author: @user, post_id: @post.id)
    @post.update_post_counter
    visit new_user_session_path
    fill_in 'Email', with: 'test@yahoo.com'
    fill_in 'Password', with: '1234567890'
    click_button 'Log in'
  end

  describe 'Test User#index view page' do
    it 'can see the username' do
      expect(page).to have_content 'zieeco'
    end

    it 'can see the image of all users' do
      expect(page.find('img')['src']).to have_content @user.photo
    end

    it 'can see the number of posts each user has written' do
      expect(page).to have_content 'Number of posts: 1'
    end

    it 'redirects me to the user show page when i click on the user' do
      click_link(title: 'view user details')
      expect(current_path).to eq user_path @user.id
    end
  end
end
