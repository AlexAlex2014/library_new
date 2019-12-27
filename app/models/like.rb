# frozen_string_literal: true

# class Like
class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :likable, polymorphic: true
  belongs_to :user

  validates :likable_id, :likable_type, :user_id, presence: true
  validates :user_id, uniqueness: { scope: %i[likable_id likable_type] }

  field :star, type: Integer, default: 0
end
