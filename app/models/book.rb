# frozen_string_literal: true

# class Book
class Book
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  paginates_per 20

  belongs_to :user
  belongs_to :category
  has_many :subscriptions, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :category_id, :image, :title, presence: true

  mount_uploader :image, AvatarUploader
  field :title, type: String
  field :author, type: String
  field :description, type: String
  field :status, type: Boolean, default: true
  field :reader, type: String
  field :rating, type: Float
end
