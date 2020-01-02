require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end
    it 'routes to #new' do
      expect(get: '/users/new').to route_to('users#new')
    end
    it 'routes to #create' do
      expect(post: '/users').to route_to('users#create')
    end
    it 'routes to #show' do
      expect(get: "/users/#{user.id}").to route_to('users#show', id: "#{user.id}")
    end
    it 'routes to #edit' do
      expect(get: "/users/#{user.id}/edit").to route_to('users#edit', id: "#{user.id}")
    end
    it 'routes to #update' do
      expect(patch: "/users/#{user.id}").to route_to('users#update', id: "#{user.id}")
    end
    it 'routes to #destroy' do
      expect(delete: "/users/#{user.id}").to route_to('users#destroy', id: "#{user.id}")
    end
  end

  describe 'GET #edit' do
    it 'response success' do
      expect(response).to be_successful
    end
  end
end
