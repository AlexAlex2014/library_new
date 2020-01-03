# frozen_string_literal: true

FactoryBot.define do
  factory :book do
    remote_image_url { FFaker::Book.orly_cover }
    title { FFaker::Book.title }
    author { FFaker::Book.author }
    description { FFaker::Book.description }
    status { true }
    rating { rand(1..5) }
  end
end
