# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  context 'expected to use before action' do
    it { is_expected.to use_before_action(:configure_sign_up_params) }
    it { is_expected.to use_before_action(:configure_account_update_params) }
  end

  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/auth/users').to route_to('users/registrations#create')
    end
    it 'routes to #new' do
      expect(get: '/auth/users/sign_up').to route_to('users/registrations#new')
    end
    it 'routes to #edit' do
      expect(get: '/auth/users/edit').to route_to('users/registrations#edit')
    end
    it 'routes to #update' do
      expect(put: '/auth/users').to route_to('users/registrations#update')
    end
    it 'routes to #destroy' do
      expect(delete: '/auth/users').to route_to('users/registrations#destroy')
    end
  end
end
