# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }
  let(:comment) { create(:comment, user_id: user.id, book_id: book.id) }
  let(:comments) do
    5.times.map do
      build(:comment, user_id: user.id, book_id: book.id)
    end
  end
  let(:valid_session) { {} }

  before do
    user.confirm
    sign_in user
    @params = {
      id: comment.id,
      book_id: book.id,
      user_id: user.id
    }
  end
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/comments').to route_to('comments#index')
    end
    it 'routes to #new' do
      expect(get: "/books/#{book.id}/comments/new")
        .to route_to('comments#new', book_id: book.id.to_s)
    end
    it 'routes to #create' do
      expect(post: "/books/#{book.id}/comments")
        .to route_to('comments#create', book_id: book.id.to_s)
    end
    it 'routes to #destroy' do
      expect(delete: "/books/#{book.id}/comments/#{comment.id}")
        .to route_to('comments#destroy', book_id: book.id.to_s,
                                         id: comment.id.to_s)
    end
  end
  context 'GET #index' do
    it 'shows all comments' do
      params = { comments: comments }
      get :index, params: params
    end
    it 'should success and render to index page' do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template :index
    end
  end
  context 'POST #create' do
    it 'redirects to comment page if validations pass' do
      params = {
        body: 'bussiness....'
      }
      post(:create, params: { user_id: user.id,
                              book_id: book.id,
                              comment: params }, format: 'js')
      expect(response).to render_template 'create'
    end
    it 'create a new comment' do
      params = {
        body: 'bussiness!!!!'
      }
      expect {
        post(:create, params: { user_id: user.id,
                                book_id: book.id,
                                comment: params }, format: 'js')
      }.to change(Comment, :count).by(1)
    end
  end
  context 'DELETE #destroy' do
    it 'should delete comment' do
      expect { delete :destroy, params: @params }
        .to change(Comment, :count).by(-1)
    end
  end
end
