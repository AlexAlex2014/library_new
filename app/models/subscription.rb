class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user
  belongs_to :book

  field :reader, type: String
end
