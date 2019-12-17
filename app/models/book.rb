class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, dependent: :destroy


  mount_uploader :image, AvatarUploader
  field :title, type: String
  field :author, type: String
  field :description, type: String
  field :status, type: Boolean, default: true
  field :reader, type: String
  field :rating, type: Float
end
