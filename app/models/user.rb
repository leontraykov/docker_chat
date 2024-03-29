# frozen_string_literal: true

# Класс User представляет модель пользователя в приложении.
# Включает модули Devise для аутентификации и регистрации.
class User < ApplicationRecord
  # Подключение модулей Devise для аутентификации пользователя.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Установление связей пользователя с сообщениями и чат-комнатами.
  # При удалении пользователя, удаляются его сообщения и связи с чат-комнатами.
  has_many :messages, dependent: :destroy
  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users

  # Валидация имени и электронной почты на наличие и уникальность.
  # Дополнительная валидация формата электронной почты.
  validates :name, :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Устанавливает имя пользователя перед валидацией при создании, если оно не задано.
  before_validation :set_name, on: :create

  # Скоуп для получения всех пользователей кроме текущего.
  scope :without_me, ->(user) { where.not(id: user.id) }

  # После создания пользователя, он транслируется для добавления в список пользователей.
  after_create_commit { broadcast_append_to 'users' }

  private

  # Устанавливает случайное имя пользователя, если оно не было задано.
  def set_name
    self.name = "Speaker ##{rand(999)}" if name.blank?
  end
end
