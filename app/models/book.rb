class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user
  has_many :subscriptions
  has_many :likes, as: :likable

  mount_uploader :image, AvatarUploader
  field :title, type: String
  field :author, type: String
  field :description, type: String
  field :status, type: Boolean, default: true
  field :reader, type: String
end
