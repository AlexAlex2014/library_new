# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeviseController, type: :controller do
  context 'expected to use before action' do
    it { is_expected.to use_before_action(:authenticate_user!) }
  end
end
