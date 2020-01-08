# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }
  let(:books) { 5.times.map { build(:book, user_id: user.id) } }
  let(:valid_session) { {} }

  before do
    user.confirm
    sign_in user
    @params = {
      id: book.id
    }
    @params_new = {
      remote_image_url: FFaker::Book.orly_cover,
      title: FFaker::Book.title,
      user_id: user.id,
      category_id: category.id
    }
  end

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/books').to route_to('books#index')
    end
    it 'routes to #create' do
      expect(post: '/books').to route_to('books#create')
    end
    it 'routes to #new' do
      expect(get: '/books/new').to route_to('books#new')
    end
    it 'routes to #edit' do
      expect(get: "/books/#{book.id}/edit")
        .to route_to('books#edit', id: book.id.to_s)
    end
    it 'routes to #update' do
      expect(put: "/books/#{book.id}")
        .to route_to('books#update', id: book.id.to_s)
    end
    it 'routes to #show' do
      expect(get: "/books/#{book.id}")
        .to route_to('books#show', id: book.id.to_s)
    end
    it 'routes to #destroy' do
      expect(delete: "/books/#{book.id}")
        .to route_to('books#destroy', id: book.id.to_s)
    end
  end

  context 'GET #index' do
    it 'shows all books' do
      params = { books: books }
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
      expect(assigns(:book)).to be_a_new(Book)
    end
    it 'should success and render to new page' do
      get :new, params: @params
      expect(response).to have_http_status(200)
      expect(response).to render_template :new
    end
  end

  context 'POST #create' do
    it "redirects to the book's page after the book is created" do
      post :create, params: { book: @params_new }
      @book = assigns(:book)
      expect(response).to redirect_to(@book)
    end
    it "renders 'new' template if valiadtions fail" do
      post :create, params: { book: { title: nil } }
      expect(response).to render_template('new')
    end
    it 'create a new book' do
      expect { post(:create, params: { book: @params_new }) }
        .to change(Book, :count).by(1)
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
    it "redirects to book's page if validations pass" do
      put :update, params: { id: book.id, book: @params_new }
      book.reload
      @book = assigns(:book)
      expect(response).to redirect_to(@book)
    end
    it 'renders #edit form if validations fail' do
      put :update, params: { id: book.id, book: { title: nil } }
      expect(response).to render_template :edit
    end
    it 'should update category info' do
      params = {
        title: 'bussiness'
      }
      put :update, params: { id: book.id, book: params }
      book.reload
      params.keys.each do |key|
        expect(book.attributes[key.to_s]).to eq params[key]
      end
    end
    it 'redirects to certain book' do
      expect(response.status).to eq(200)
    end
    it 'updates the book' do
      params = {
        title: 'cars'
      }
      put :update, params: { id: book.id, book: params }
      book.reload
      expect(book).to having_attributes(title: 'cars')
    end
  end

  context 'DELETE #destroy' do
    it 'should delete book' do
      expect { delete :destroy, params: @params }
        .to change(Book, :count).by(-1)
    end
  end
end
