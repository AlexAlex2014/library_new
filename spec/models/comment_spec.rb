# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { is_expected.to be_mongoid_document }

  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }
  let(:comment) { create(:comment, user_id: user.id, book_id: book.id) }

  describe 'columns' do
    %i[
      body
    ].each do |field|
      it { is_expected.to have_field(field).of_type(String) }
    end
    %i[
      user_id book_id
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Object) }
    end
    %i[
      created_at updated_at
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Time) }
    end
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(comment).to be_valid
    end
    it 'is not valid without an image_id' do
      comment2 = build(:comment, book_id: nil)
      expect(comment2).not_to be_valid
    end
    it 'is not valid without an commenter' do
      comment2 = build(:comment, body: nil)
      expect(comment2).not_to be_valid
    end
    it 'is not valid without an user_id' do
      comment2 = build(:comment, user_id: nil)
      expect(comment2).not_to be_valid
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
