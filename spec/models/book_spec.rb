# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to be_mongoid_document }

  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:book) { create(:book, user_id: user.id, category_id: category.id) }

  describe 'validations' do
    %i[
      title author
      description reader
    ].each do |field|
      it { is_expected.to have_field(field).of_type(String) }
    end
    %i[
      image
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Object) }
    end
    %i[
      created_at updated_at deleted_at
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Time) }
    end
    %i[
      rating
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Float) }
    end
    %i[
      status
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Mongoid::Boolean) }
    end
    context 'presence fields' do
      it { is_expected.to validate_presence_of(:image) }
    end
    context 'presence fields' do
      it { is_expected.to validate_presence_of(:title) }
    end
    context 'presence fields' do
      it { is_expected.to validate_presence_of(:category_id) }
    end
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(book).to be_valid
    end
    it 'is not valid without a password' do
      book1 = build(:book, image: nil)
      expect(book1).not_to be_valid
    end
    it 'is not valid without an email' do
      book1 = build(:book, title: nil)
      expect(book1).not_to be_valid
    end
    it 'is not valid without an email' do
      book1 = build(:book, category_id: nil)
      expect(book1).not_to be_valid
    end
  end

  describe 'Associations' do
    context 'have_many' do
      %i[subscriptions likes comments].each do |association|
        it { is_expected.to have_many_related(association) }
      end
    end
    context 'belong_to' do
      %i[user category].each do |association|
        it { is_expected.to belong_to_related(association) }
      end
    end
  end
end
