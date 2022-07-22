require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.feature 'Login page', type: :feature do
  before(:each) do
    User.create(name: 'zieeco', photo: 'photo_link', bio: 'Programmer From Nigeria', email: 'test@yahoo.com',
                password: '1234567890', confirmed_at: Time.now)
    visit user_session_path
  end

  describe 'Test login view' do
    it 'I can see the username and password inputs and the "Submit/Login" button' do
      expect(page).to have_field(type: 'email')
      expect(page).to have_field(type: 'password')
      expect(page).to have_button(type: 'submit')
    end

    it 'without filling in the username and the password get error' do
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password.'
    end

    it 'gets a detailed error with incorrect data.' do
      visit user_session_path
      fill_in 'Email', with: 'test@yahoo.com'
      fill_in 'Password', with: 'passport'
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password'
    end

    it 'sign me in successfully' do
      visit user_session_path
      fill_in 'Email', with: 'test@yahoo.com'
      fill_in 'Password', with: '1234567890'
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'
    end

    it 'direct me to the root page' do
      visit user_session_path
      fill_in 'Email', with: 'test@yahoo.com'
      fill_in 'Password', with: '1234567890'
      click_button 'Log in'
      expect(current_path).to eq root_path
    end
  end
end
# rubocop:enable Metrics/BlockLength
