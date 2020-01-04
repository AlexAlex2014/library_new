require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:categories) { 5.times.map { build(:category) } }
  let(:valid_session) { {} }

  before do
    user.confirm
    sign_in user
    @params = {
      id: category.id
    }
  end

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/categories').to route_to('categories#index')
    end
    it 'routes to #create' do
      expect(post: '/categories').to route_to('categories#create')
    end
    it 'routes to #new' do
      expect(get: '/categories/new').to route_to('categories#new')
    end
    it 'routes to #edit' do
      expect(get: "/categories/#{category.id}/edit").to route_to('categories#edit', id: "#{category.id}")
    end
    it 'routes to #update' do
      expect(put: "/categories/#{category.id}").to route_to('categories#update', id: "#{category.id}")
    end
    it 'routes to #show' do
      expect(get: "/categories/#{category.id}").to route_to('categories#show', id: "#{category.id}")
    end
    it 'routes to #destroy' do
      expect(delete: "/categories/#{category.id}").to route_to('categories#destroy', id: "#{category.id}")
    end
    it 'routes to #subjects' do
      expect(get: 'subjects')
          .to route_to('categories#subjects')
    end
  end

  context 'GET #index' do
    it 'shows all categories' do
      params = { categories: categories }
      get :index, params: params
    end
    it 'should success and render to index page' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template :index
    end
  end

  context 'GET #show' do
    it 'should success and render to show page' do
      get :show, params: @params
      expect(response).to have_http_status(200)
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new category as @category' do
      get :new, params: {}, session: valid_session
      expect(assigns(:category)).to be_a_new(Category)
    end
    it 'should success and render to new page' do
      get :new, params: @params
      expect(response).to have_http_status(200)
      expect(response).to render_template :new
    end
  end

  context 'POST #create' do
    it "redirects to the category's page after the category is created" do
      post :create, params: { category: { remote_image_url: FFaker::Book.orly_cover, name: 'Car' } }
      @categories = assigns(:categories)
      expect(response).to redirect_to(@categories)
    end
    it "renders 'new' template if valiadtions fail" do
      post :create, params: { category: { name: nil } }
      expect(response).to render_template('new')
    end
    it 'create a new category' do
      params = {
          remote_image_url: FFaker::Book.orly_cover,
          name: 'bussiness'
      }
      expect { post(:create, params: { category: params }) }
          .to change(Category, :count).by(1)
    end
  end

  context 'GET #edit' do
    it 'should success and render to show page' do
      get :edit, params: @params
      expect(response).to have_http_status(200)
      expect(response).to render_template :edit
    end
  end

  context 'PUT #update' do
    it "redirects to category's page if validations pass" do
      put :update, params: { id: category.id, category: { remote_image_url: FFaker::Book.orly_cover, name: 'NewCar' } }
      expect(response).to redirect_to(category)
    end
    it 'renders #edit form if validations fail' do
      put :update, params: { id: category.id, category: { name: nil } }
      expect(response).to render_template :edit
    end
    it 'should update category info' do
      params = {
          name: 'bussiness'
      }
      put :update, params: { id: category.id, category: params }
      category.reload
      params.keys.each do |key|
        expect(category.attributes[key.to_s]).to eq params[key]
      end
    end
    it 'redirects to certain category' do
      expect(response.status).to eq(200)
    end
    it 'updates the category' do
      params = {
          name: 'cars'
      }
      put :update, params: { id: category.id, category: params }
      category.reload
      expect(category).to having_attributes(name: 'cars')
    end
  end

  context 'DELETE #destroy' do
    it 'should delete category' do
      expect { delete :destroy, params: @params }
          .to change(Category, :count).by(-1)
    end
  end

  context 'GET #subjects' do
    it 'shows all subjects' do
      params = { categories: categories }
      get :subjects, params: params
    end
    it 'should success and render to subjects page' do
      get :subjects
      expect(response).to have_http_status(200)
      expect(response).to render_template :subjects
    end
  end
end
