# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.paragraph }
    parent_id { nil }
    user
    post

    trait :with_parent do
      association :parent, factory: :comment
    end
  end
end
