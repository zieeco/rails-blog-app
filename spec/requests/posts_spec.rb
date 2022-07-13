require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    before(:example) do
      get '/users/100/posts'
    end

    it 'successful request' do
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      expect(response.body).to render_template(:index)
    end

    it 'renders the placeholder text' do
      expect(response.body).to include('List of all Posts')
    end

    it 'does not render a different template' do
      expect(response.body).to_not render_template(:new)
      expect(response.body).to_not render_template(:show)
    end
  end

  describe 'GET #show' do
    before(:example) do
      get '/users/100/posts/100'
    end

    it 'a successful request' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'get the contents in the user show page' do
      expect(response.body).to include('Post details')
    end

    it 'does not render a different template' do
      expect(response).to_not render_template(:index)
      expect(response).to_not render_template(:new)
    end
  end
end
