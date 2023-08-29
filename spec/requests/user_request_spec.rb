require 'rails_helper'

RSpec.describe 'users' do
  describe 'users/index', type: :view do
    it 'response body includes correct placeholder text' do
      render template: 'users/index'

      expect(rendered).to have_selector('h1', text: 'Here is a index page for a given user')
    end
  end
  describe 'users/show', type: :view do
    it 'response body includes correct placeholder text' do
      render template: 'users/show'

      expect(rendered).to have_selector('h1', text: 'Here is a index page for a given user')
    end
  end

  describe 'GET /index' do
    it 'response status was correct' do
      get '/users/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /index' do
    it 'response status was correct' do
      get '/users/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'users' do
    it 'renders the index template' do
      get '/users'

      expect(response).to render_template('index')
    end
    it 'renders the index template' do
      get '/users/user_id'

      expect(response).to render_template('show')
    end
  end
end
