# frozen_string_literal: true

FactoryBot.define do
  sequence(:title) { |n| "NoteTitle-#{n}" }

  factory :note do
    title { generate(:title) }
    body { 'Note Body' }

    association :user

    trait :invalid do
      title { nil }
    end
  end
end
