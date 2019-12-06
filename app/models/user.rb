class User
  include Mongoid::Document
  include Mongoid::Timestamps # created_at and updated_at.
  include Mongoid::Paranoia

  has_many :books
  belongs_to :master_account, class_name: 'User', optional: true
  has_many :users, class_name: 'User', foreign_key: 'master_account_id'
  has_many :subscriptions, dependent: :destroy
  has_many :likes, dependent: :destroy

  devise :database_authenticatable,
         :omniauthable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  ## Database authenticatable
  field :name,              type: String, default: ""
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  field :uid,                  type: String
  field :provider,             type: String
  field :master,               type: Boolean, default: true
  field :master_account_id,    type: String
  field :deleted_at,           type: DateTime

  def self.my(master_account_id)
    where(master_account_id: master_account_id)
  end

  def get_master_account
    self.master ? self : self.master_account
  end

  def will_save_change_to_email?
    false
  end
end
