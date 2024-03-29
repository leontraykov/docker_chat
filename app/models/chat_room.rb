# frozen_string_literal: true

# Класс ChatRoom представляет модель чат-комнаты в приложении.
# Чат-комната может содержать множество пользователей и сообщений.
class ChatRoom < ApplicationRecord
  # Устанавливает связь с chat_room_users и users. При удалении чат-комнаты удаляются и связанные с ней chat_room_users.
  has_many :chat_room_users, dependent: :delete_all
  has_many :users, through: :chat_room_users

  # Устанавливает связь с сообщениями. При удалении чат-комнаты удаляются и связанные с ней сообщения.
  has_many :messages, dependent: :delete_all

  # Валидация наличия и уникальности названия чат-комнаты.
  validates :name, presence: true, uniqueness: true

  # Перед валидацией на создание устанавливает название чат-комнаты, если оно не задано.
  before_validation :set_name, on: :create

  # После создания чат-комнаты выполняет трансляцию для добавления в список чат-комнат.
  after_create_commit { broadcast_append_to 'chat_rooms' }

  # Создает чат-комнату с участием пользователя.
  def self.create_with_user(params, user)
    chat_room = create(params)
    chat_room.users << user if chat_room.persisted?
    chat_room
  end

  private

  # Устанавливает случайное название для чат-комнаты, если оно не было задано.
  def set_name
    self.name = "Chat Room ##{rand(999)}" if name.blank?
  end
end
