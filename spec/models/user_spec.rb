# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = create(:user)
  end

  describe 'columns' do
    %i[
      id email encrypted_password reset_password_token
      reset_password_sent_at remember_created_at sign_in_count
      current_sign_in_at last_sign_in_at current_sign_in_ip
      last_sign_in_ip confirmation_token confirmed_at
      confirmation_sent_at unconfirmed_email created_at updated_at
      provider uid name master master_account_id deleted_at
    ].each do |field|
      it { is_expected.to have_db_column(field) }
    end
    %i[
      confirmation_token email
    ].each do |field|
      it { is_expected.to have_db_index(field) }
    end
  end

  context 'validation' do
    it 'is valid with valid attributes' do
      expect(@user1).to be_valid
    end

    it 'has a unique email' do
      user2 = build(:user_val, email: 'mike@gmail.com')
      expect(user2).not_to be_valid
    end

    it 'has a non-unique first_name' do
      user2 = build(:user, email: 'bob1@gmail.com', first_name: 'White')
      expect(user2).to be_valid
    end

    it 'has a non-unique last_name' do
      user2 = build(:user, email: 'bob2@gmail.com', last_name: 'Bob')
      expect(user2).to be_valid
    end

    it 'is not valid without a password' do
      user2 = build(:user, email: 'bob3@gmail.com', password: nil)
      expect(user2).not_to be_valid
    end

    it 'is not valid without an email' do
      user2 = build(:user, email: nil)
      expect(user2).not_to be_valid
    end
    # it "raises exception if user has no confirm" do
    #   expect( -> { create(:user) } ).to raise_exception
    # end
  end

  describe 'Associations' do
    context 'have_many' do
      %i[categories comments likes subs images actions].each do |association|
        it { is_expected.to have_many(association) }
      end
    end

    context 'have_one' do
      %i[profile].each do |association|
        it { is_expected.to have_one(association) }
      end
    end
  end

  describe '#full_name' do
    it 'has a full_name' do
      expect(@user1.full_name).to eq 'Tyson' + ' ' + 'Mike'
    end

    it 'is valid without first_name' do
      expect(build(:user, email: 'bob4@gmail.com', first_name: nil)).to be_valid
    end

    it 'is valid without last_name' do
      expect(build(:user, email: 'bob5@gmail.com', last_name: nil)).to be_valid
    end

    it 'is valid without first_name & last_name' do
      expect(build(:user, email: 'bob6@gmail.com',
                   first_name: nil, last_name: nil)).to be_valid
    end
  end

  describe '.logins_before_captcha' do
    it 'has a logins_before_captcha' do
      expect(User.logins_before_captcha).to eq 2
    end
  end
end
