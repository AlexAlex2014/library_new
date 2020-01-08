# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to be_mongoid_document }

  let(:user) { create(:user) }

  describe 'validations' do
    %i[
      email encrypted_password reset_password_token
      current_sign_in_ip
      last_sign_in_ip confirmation_token
      unconfirmed_email
      provider uid name master_account_id
    ].each do |field|
      it { is_expected.to have_field(field).of_type(String) }
    end
    %i[
      reset_password_sent_at remember_created_at
      current_sign_in_at last_sign_in_at confirmed_at
      confirmation_sent_at created_at updated_at
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Time) }
    end
    %i[
      sign_in_count
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Integer) }
    end
    %i[
      master
    ].each do |field|
      it { is_expected.to have_field(field).of_type(Mongoid::Boolean) }
    end
    %i[
      deleted_at
    ].each do |field|
      it { is_expected.to have_field(field).of_type(DateTime) }
    end
    context 'presence fields' do
      it { is_expected.to validate_presence_of(:email) }
    end
    context 'presence fields' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end
    it 'has a non-unique first_name' do
      user1 = build(:user_val, email: 'bob1@gmail.com', name: 'Bob')
      expect(user1).to be_valid
    end
    it 'is not valid without a password' do
      user1 = build(:user_val, email: 'bob3@gmail.com', password: nil)
      expect(user1).not_to be_valid
    end
    it 'is not valid without an email' do
      user1 = build(:user_val, email: nil)
      expect(user1).not_to be_valid
    end
    it 'is not valid without an email' do
      user1 = build(:user_val, name: nil)
      expect(user1).not_to be_valid
    end
  end

  describe 'Associations' do
    context 'have_many' do
      %i[users books subscriptions likes comments].each do |association|
        it { is_expected.to have_many_related(association) }
      end
    end

    context 'belong_to' do
      %i[master_account].each do |association|
        it { is_expected.to belong_to_related(association) }
      end
    end
  end
end
