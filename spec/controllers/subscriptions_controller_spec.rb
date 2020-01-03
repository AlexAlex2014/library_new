require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }

  let(:subscription) { create(:subscription, user_id: user.id, book_id: book.id) }
  let!(:subscriptions) { 5.times.map { build(:subscription, user_id: user.id, book_id: book.id) } }
  let(:valid_session) { {} }

  before do
    user.confirm
    sign_in user
    @params = {
      user_id: user.id,
      book_id: book.id
    }
    @find_subscription = {
      id: subscription.id,
      book_id: book.id
    }
  end

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/subscriptions').to route_to('subscriptions#index')
    end
    it 'routes to #create' do
      expect(post: '/subscriptions').to route_to('subscriptions#create')
    end
    it 'routes to #destroy' do
      expect(delete: "/subscriptions/#{subscription.id}").to route_to('subscriptions#destroy', id: "#{subscription.id}")
    end
  end

  context 'GET #index' do
    it 'shows all subscriptions' do
      parametrs = { book_id: book.id, subscriptions: subscriptions }
      get :index, params: parametrs
    end
    it 'should success and render to index page' do
      get :index, params: { book_id: book.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template :index
    end
  end

  context 'POST #create' do
    it 'redirects to subscription page if validations pass' do
      from(fallback_location: root_path)
      post(:create, params: { book_id: book.id, subscription: @params })
      expect(response).to redirect_to(fallback_location: root_path)
    end
    it 'create a new subscription' do
      expect {
        post(:create, params: { book_id: book.id, subscription: @params })
      }.to change(Subscription, :count).by(1)
    end
  end

  context 'DELETE #destroy' do
    it 'should delete subscription' do
      expect {
        delete(:destroy, params: @find_subscription)
      }.to change(Subscription, :count).by(-1)
    end
    it 'redirects after destroy' do
      from(fallback_location: root_path)
      delete(:destroy, params: @find_subscription)
      expect(response).to redirect_to(fallback_location: root_path)
    end
  end
end
