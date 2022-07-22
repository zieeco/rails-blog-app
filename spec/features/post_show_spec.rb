require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'Post Show view', type: :feature do
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
    @comment = Comment.create(text: 'My second comment', author_id: @user.id, post_id: @post.id)
    @comment.update_comments_counter
    @like = Like.create(author: @user, post_id: @post.id)
    @like.update_likes_counter
    visit new_user_session_path
    fill_in 'Email', with: 'test@yahoo.com'
    fill_in 'Password', with: '1234567890'
    click_button 'Log in'
    visit user_posts_path(user_id: @post.author_id, id: @post.id)
  end

  describe 'Post#show view' do
    it 'test the posts title.' do
      expect(page).to have_content 'Hello'
    end

    it 'test the posts body or text' do
      expect(page).to have_content 'This is my first post'
    end

    it 'Can see who wrote the post' do
      expect(page).to have_content 'zieeco'
    end

    it 'how many comments it has' do
      expect(page).to have_content 'Comments: 2'
    end

    it 'how many likes it has' do
      expect(page).to have_content 'Likes: 1'
    end

    it 'name of each commentor' do
      expect(page).to have_content 'zieeco'
    end

    it 'Can see the comment each commentor left' do
      expect(page).to have_content 'My first comment'
      expect(page).to have_content 'My second comment'
    end
  end
end
# rubocop:enable Metrics/BlockLength
