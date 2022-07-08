require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'testing the Post model' do
    before(:example) do
      @user = User.new(id: 1, name: 'zieeco', photo: 'photo_link', bio: 'Full Stack Developer')
      @post = Post.new(author: @user, title: 'post 1', text: 'post content', comments_counter: 0, likes_counter: 0)
    end

    it 'attributes meets validation' do
      expect(@post).to be_valid
    end

    it 'if title exists' do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'if it has a max of 250 characters' do
      @post.title = 'Testing length'
      expect(@post).to be_valid
    end

    it 'test if comments counter is a number' do
      @post.comments_counter = 1.00
      expect(@post).not_to be_valid
    end

    it 'test if comments counter is a number' do
      @post.comments_counter = 500
      expect(@post).to be_valid
    end

    it 'test if likes counter is a number' do
      @post.likes_counter = 500
      expect(@post).to be_valid
    end

    it 'test if likes counter is a number' do
      @post.likes_counter = 'string'
      expect(@post).not_to be_valid
    end

    it 'test if comments counter is greater than or equal to zero' do
      @post.comments_counter = -19
      expect(@post).to_not be_valid
    end

    it 'if likes counter is greater than or equal to zero' do
      @post.likes_counter = -199
      expect(@post).to_not be_valid
    end
  end
end
