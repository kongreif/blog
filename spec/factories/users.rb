# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }

    trait :admin do
      admin { true }
    end
  end
end
