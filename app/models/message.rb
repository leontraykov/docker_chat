# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  validates :content, presence: true

  after_create_commit { broadcast_append_to chat_room }

  def self.create_for_chat_room(content, user, chat_room_id)
    message = new(content:, user:, chat_room_id:)
    message.save
    message
  end
end
