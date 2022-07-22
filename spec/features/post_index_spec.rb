require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'Post Index view', type: :feature do
  before(:each) do
    @user = User.create(name: 'zieeco', photo: 'photo_link', bio: 'Programmer From Nigeria', email: 'test@yahoo.com',
                        password: '1234567890', confirmed_at: Time.now)

    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post')
    (1..5).each do |i|
      @user.posts.create title: "Post #{i}", text: "This is my #{i} post!"
      @post.update_post_counter
    end
    @comment = Comment.create(text: 'My first comment', author_id: @user.id, post_id: @post.id)
    @comment.update_comments_counter
    @like = Like.create(author: @user, post_id: @post.id)
    @like.update_likes_counter
    visit new_user_session_path
    fill_in 'Email', with: 'test@yahoo.com'
    fill_in 'Password', with: '1234567890'
    click_button 'Log in'
    visit user_posts_path(@user.id)
  end

  describe 'Test post#index view' do
    it 'can see the username' do
      expect(page).to have_content 'zieeco'
    end

    it 'can see the image of all users' do
      expect(page.find('img')['src']).to have_content @user.photo
    end

    it 'can see the number of post the user has' do
      expect(page).to have_content 'Number of posts: 5'
    end

    it 'can see the post title' do
      expect(page).to have_content 'Hello'
    end

    it 'can see some of the post body or text' do
      expect(page).to have_content 'This is my first post'
    end

    it 'see the first comments on a post' do
      expect(page).to have_content 'My first comment'
    end

    it 'I can see how many comments a post has' do
      expect(page).to have_content 'Comments: 1'
    end

    it 'I can see how many likes a post has' do
      expect(page).to have_content 'Likes: 1'
    end

    it 'it redirects me to that post show page, when i clik on the post' do
      visit user_post_path(@user.id, @post.id)
      expect(current_path).to eq user_post_path(@user.id, @post.id)
    end
  end
end
# rubocop:enable Metrics/BlockLength
