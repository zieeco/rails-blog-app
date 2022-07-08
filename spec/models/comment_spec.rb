require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validation for the Comment model' do
    before(:example) do
      @user = User.new(name: 'zieeco', photo: 'photo_link', bio: 'Developer From Nigeria')
      @post = Post.new(author: @user, title: 'My Title', comments_counter: 0, likes_counter: 0)
      @comment = Comment.new(text: 'First comment', author_id: @user.id, post_id: @post.id)
    end

    it 'if text is present' do
      @comment.text = nil
      expect(@comment).to_not be_valid
    end

    it 'test if author_id is integer' do
      @comment.author_id = 'string'
      expect(@comment).to_not be_valid
    end

    it 'test if post_id is integer' do
      @comment.post_id = 'string'
      expect(@comment).to_not be_valid
    end

    it 'test if comment counter is updated' do
      expect(@post.comments_counter).to_not eq 5
    end
  end
end
