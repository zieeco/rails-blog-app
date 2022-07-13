require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) { get users_path }

    it 'successful request' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it 'should render the placeholder text' do
      expect(response.body).to include('List of Users')
    end
  end

  describe 'GET #show' do
    before(:example) { get user_path(100) }

    it 'successful request' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response.body).to render_template(:show)
    end

    it 'renders the placeholder text' do
      expect(response.body).to include('User Details')
    end

    it 'should not render a different template' do
      expect(response.body).to_not render_template(:new)
      expect(response.body).to_not render_template(:index)
    end
  end
end
