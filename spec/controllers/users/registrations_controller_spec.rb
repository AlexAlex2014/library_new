# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseController, type: :controller do
  context '' do
    it { is_expected.to use_before_action(:configure_sign_up_params) }
    it { is_expected.to use_before_action(:configure_account_update_params) }
  end
end
