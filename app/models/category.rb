class Book
  include Mongoid::Document
  include Mongoid::Timestamps # created_at and updated_at.

  field :name, type: String
end