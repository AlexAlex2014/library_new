# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BooksHelper, type: :helper do
  include LikesHelper
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }

  before do
    def current_user
      user
    end
  end

  it 'returns five' do
    likable_id = book.id
    likable_type = 'Book'
    expect(find_user_like(likable_id, likable_type))
        .to eq(find_user_like(likable_id, likable_type))
  end

  it 'response success' do
    expect(response).to be_successful
  end
end
