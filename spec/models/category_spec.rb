# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to be_mongoid_document }

  let(:user) { create(:user) }
  let(:category) { create(:category) }

  describe 'validations' do
    %i[
      name
    ].each do |field|
      it { is_expected.to have_field(field).of_type(String) }
    end
    %i[
      image
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Object) }
    end
    %i[
      created_at updated_at
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Time) }
    end
    context 'presence fields' do
      it { is_expected.to validate_presence_of(:image) }
    end
    context 'presence fields' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(category).to be_valid
    end
    it 'is not valid without a password' do
      category1 = build(:category, image: nil)
      expect(category1).not_to be_valid
    end
    it 'is not valid without an email' do
      category1 = build(:category, name: nil)
      expect(category1).not_to be_valid
    end
  end

  describe 'Associations' do
    context 'have_many' do
      %i[books].each do |association|
        it { is_expected.to have_many_related(association) }
      end
    end
  end
end
