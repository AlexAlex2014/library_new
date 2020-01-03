# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    remote_image_url { FFaker::Book.orly_cover }
    name { FFaker::Name.name }
  end
end
