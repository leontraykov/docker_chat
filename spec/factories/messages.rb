# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { 'This is a test message.' }
    association :user
    association :chat_room
  end
end
