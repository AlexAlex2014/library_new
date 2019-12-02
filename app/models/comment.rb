class Comment
  include Mongoid::Document
  field :title, type: String
  field :user, type: String
end
