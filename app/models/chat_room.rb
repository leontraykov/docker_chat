# frozen_string_literal: true

class ChatRoom < ApplicationRecord
  has_many :chat_room_users, dependent: :delete_all
  has_many :users, through: :chat_room_users
  has_many :messages, dependent: :delete_all

  validates :name, presence: true, uniqueness: true
  before_validation :set_name, on: :create

  after_create_commit { broadcast_append_to 'chat_rooms' }

  def self.create_with_user(params, user)
    chat_room = create(params)
    chat_room.users << user if chat_room.persisted?
    chat_room
  end

  private

  def set_name
    self.name = "Chat Room ##{rand(999)}" if name.blank?
  end
end
