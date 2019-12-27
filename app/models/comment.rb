# frozen_string_literal: true

# class Comment
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user # , optional: true
  belongs_to :book

  validates :body, :book_id, :user_id, presence: true

  field :body, type: String
end
