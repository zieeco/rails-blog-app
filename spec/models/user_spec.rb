require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validation for the User model' do
    before(:example) do
      @user = User.new(name: 'Isaac', photo: 'photo_link', bio: 'my bio')
    end

    before { @user.save }

    it 'must not be blank' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'post counter must be a number' do
      @user.posts_counter = 'hahaha'
      expect(@user).to_not be_valid
    end

    it 'post counter must not be less than 0' do
      @user.posts_counter = 90_00.0000
      expect(@user).to_not be_valid
    end

    it 'should have 0 post' do
      expect(@user.recent_posts.length).to eq 0
    end
  end
end
