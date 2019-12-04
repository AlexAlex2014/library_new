class Book
  include Mongoid::Document
  include Mongoid::Timestamps # created_at and updated_at.

  belongs_to :user
  has_many :subscriptions # , as: :subscriptionable, dependent: :destroy


  mount_uploader :image, AvatarUploader
  field :title, type: String
  field :author, type: String
  field :description, type: String
  field :status, type: Boolean, default: true
  field :reader, type: String

end
