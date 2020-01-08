# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionsHelper, type: :helper do
  include SubscriptionsHelper
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }
  let(:subscription) do
    create(:subscription, user_id: user.id, book_id: book.id)
  end

  before do
    def current_user
      user
    end
  end

  it 'returns five' do
    subscriptionable_id = book.id
    subscriptionable_type = 'Book'

    expect(find_user_sub(subscriptionable_id, subscriptionable_type))
      .to eq(find_user_sub(subscriptionable_id, subscriptionable_type))
  end

  it 'response success' do
    expect(response).to be_successful
  end
end
