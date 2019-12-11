class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia


  # belongs_to :subscriptionable, polymorphic: true
  belongs_to :user
  belongs_to :book


  # field :subscriptionable_type, type: String
  field :reader, type: String

end
