# frozen_string_literal: true

# Класс Message представляет модель сообщения в чате.
# Сообщение связано с пользователем и чат-комнатой.
class Message < ApplicationRecord
  # Сообщение принадлежит пользователю и чат-комнате.
  belongs_to :user
  belongs_to :chat_room

  # Проверка наличия содержимого сообщения.
  validates :content, presence: true

  # После создания сообщения, оно транслируется в соответствующую чат-комнату.
  after_create_commit { broadcast_append_to chat_room }

  # Создает и сохраняет новое сообщение для чат-комнаты.
  def self.create_for_chat_room(content, user, chat_room_id)
    message = new(content:, user:, chat_room_id:)
    message.save
    message
  end
end
