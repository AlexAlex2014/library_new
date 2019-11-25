class Book
  include Mongoid::Document
  include Mongoid::Timestamps # created_at and updated_at.

  belongs_to :user

  mount_uploader :image, AvatarUploader
  field :name, type: String
  field :author, type: String
  field :status, type: String




end
