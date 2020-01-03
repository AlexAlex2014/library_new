require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:users) { 5.times.map { build(:user) } }
  let(:valid_session) { {} }

  before do
    user.confirm
    sign_in user
    @params = {
        name: 'AAAA',
        email: 'asas@gmail.com',
        password: '123456'
    }
    @find_user = {
        id: user.id
    }
  end

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

  context 'GET #index' do
    it 'shows all users' do
      parametrs = { users: users }
      get :index, params: parametrs
    end
    it 'should success and render to index page' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      get :new, params: {}, session: valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'should success and render to new page' do
      get :new, params: { id: user.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :new
    end
  end

  context 'POST #create' do
    it 'redirects to user page if validations pass' do
      post(:create, params: { user: @params })
      @user = assigns(:user)
      expect(response).to redirect_to(@user)
    end
    it 'create a new user' do
      expect {
        post(:create, params: { user: @params })
      }.to change(User, :count).by(1)
    end
  end

  context 'GET #show' do
    it 'should success ' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :show
    end
  end

  context 'GET #edit' do
    it 'assigns the requested user as @user' do
      get :edit, params: { id: user.id, user: @params },
          session: valid_session
      expect(assigns(:user)).to eq(user)
    end
    it 'should success and render to edit page' do
      get :edit, params: { id: user.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :edit
    end
  end

  context 'PUT #update' do
    it "redirects to user's page if validations pass" do
      put :update, params: { id: user.id, user: @params }
      user.reload
      @user = assigns(:user)
      expect(response).to redirect_to(@user)
    end
    it 'should update user info' do
      params = {
          name: 'AAAA',
          email: 'asas@gmail.com'
      }
      put :update, params: { id: user.id, user: params }
      user.reload
      params.keys.each do |key|
        expect(user.attributes[key.to_s]).to eq params[key]
      end
    end
    it 'redirects to certain user' do
      expect(response.status).to eq(200)
    end
    it 'updates the user' do
      put :update, params: { id: user.id, user: @params }
      user.reload
      expect(user).to having_attributes(name: 'AAAA')
    end
  end

  context 'DELETE #destroy' do
    it 'should delete user' do
      expect {
        delete(:destroy, params: @find_user)
      }.to change(User, :count).by(-1)
    end
    it 'redirects after destroy' do
      delete :destroy, params: @find_user
      expect(response).to redirect_to(users_path)
    end
  end
end
