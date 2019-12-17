class Category
  include Mongoid::Document
  include Mongoid::Timestamps # created_at and updated_at.

  has_many :books

  field :name, type: String
end