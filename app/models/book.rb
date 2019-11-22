class Book
  # mount_uploader :avatar, AvatarUploader

  include Mongoid::Document
  include Mongoid::Timestamps # created_at and updated_at.

  field :iamge, type: String
  field :name, type: String
  field :author, type: String
  field :status, type: String
end
