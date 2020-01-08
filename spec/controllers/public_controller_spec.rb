# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  let(:user) { create(:user) }

  describe 'routing' do
    it 'routes to #create' do
      expect(get: '/').to route_to('public#home')
    end
  end

  describe 'GET #home' do
    it 'response with 200 ' do
      get :home
      expect(response.response_code).to eq(200)
    end
    it 'renders the index template' do
      get :home
      expect(response).to render_template('public/home')
    end

    context 'response with redirect and success' do
      before do
        sign_in user
      end
      it 'response with success' do
        sign_out user
        get :home
        expect(response).to be_successful
      end
    end
  end
end
