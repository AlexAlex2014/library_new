class Position
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :category
  belongs_to :book

  field :quantity, type: Float
end
