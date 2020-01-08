# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  it { is_expected.to be_mongoid_document }

  let(:user) { create(:user_val) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }
  let(:like) { create(:like, likable: book, user_id: user.id) }

  describe 'columns' do
    %i[
      likable_type
    ].each do |field|
      it { is_expected.to have_field(field).of_type(String) }
    end
    %i[
      user_id likable_id
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Object) }
    end
    %i[
      star
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Integer) }
    end
    %i[
      created_at updated_at
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Time) }
    end
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(like).to be_valid
    end
    it 'has a unique user_id' do
      like2 = build(:like, user_id: 2)
      expect(like2).not_to be_valid
    end
    it 'is not valid without a user_id' do
      like2 = build(:like, user_id: nil)
      expect(like2).not_to be_valid
    end
    it 'is not valid without a likable_type' do
      like2 = build(:like, likable_type: nil)
      expect(like2).not_to be_valid
    end
    it 'is not valid without a likable_id' do
      like2 = build(:like, likable_id: nil)
      expect(like2).not_to be_valid
    end
  end

  describe 'Associations' do
    context 'belong_to' do
      %i[user likable].each do |association|
        it { is_expected.to belong_to_related(association) }
      end
    end
  end
end
