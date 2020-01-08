# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { is_expected.to be_mongoid_document }

  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }
  let(:subscription) do
    create(:subscription, user_id: user.id, book_id: book.id)
  end

  describe 'validations' do
    %i[
      user_id book_id
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Object) }
    end
    %i[
      created_at updated_at deleted_at
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Time) }
    end
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(subscription).to be_valid
    end
    it 'is not valid without an user_id' do
      user1 = build(:subscription, user_id: nil)
      expect(user1).not_to be_valid
    end
    it 'is not valid without a book_id' do
      user1 = build(:subscription, book_id: nil)
      expect(user1).not_to be_valid
    end
  end

  describe 'Associations' do
    context 'belong_to' do
      %i[user book].each do |association|
        it { is_expected.to belong_to_related(association) }
      end
    end
  end
end
