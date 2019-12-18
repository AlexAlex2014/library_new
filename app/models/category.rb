class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :books

  validates :image, :name, presence: true

  field :name, type: String
  mount_uploader :image, AvatarUploader
end