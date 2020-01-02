# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  context 'expected to use before action' do
    it { is_expected.to use_before_action(:configure_sign_up_params) }
    it { is_expected.to use_before_action(:configure_account_update_params) }
  end
end
