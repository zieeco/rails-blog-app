require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Validation for the Like model' do
    before(:example) do
      @user = User.create(name: 'Isaac', photo: 'photo_link', bio: 'Developer from Nigeria')
      @post = Post.create(author: @user, title: 'My title', text: 'My text')
      @like = Like.create(author: @user, post_id: @post.id)
    end

    it 'if author_id is present' do
      @like.author_id = false
      expect(@like).not_to be_valid
    end

    it 'if post_id is present' do
      @like.post_id = nil
      expect(@like).to_not be_valid
    end

    it 'like must be present' do
      expect(@post.likes.length).to eq 0
    end

    it 'likes counter should be an integer' do
      @post.likes_counter = 'likes_counter'
      expect(@like).to_not be_valid
    end

    it 'likes counter should be greater than or equal to zero' do
      @post.likes_counter = -1
      expect(@like).to_not be_valid
    end
  end
end
