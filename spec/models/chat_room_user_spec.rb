# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatRoomUser, type: :model do
  describe 'associations' do
    it 'belongs to user' do
      chat_room_user = ChatRoomUser.new
      expect(chat_room_user).to respond_to(:user)
    end

    it 'belongs to chat_room' do
      chat_room_user = ChatRoomUser.new
      expect(chat_room_user).to respond_to(:chat_room)
    end
  end

  describe 'validations' do
    it 'validates uniqueness of user_id with chat_room_id' do
      user = create(:user)
      chat_room = create(:chat_room)
      create(:chat_room_user, user:, chat_room:)
      duplicate = build(:chat_room_user, user:, chat_room:)
      expect(duplicate).not_to be_valid
    end
  end

  describe 'dependencies' do
    let!(:user) { create(:user) }
    let!(:chat_room) { create(:chat_room) }
    let!(:chat_room_user) { create(:chat_room_user, user:, chat_room:) }

    it 'is destroyed when user is destroyed' do
      expect { user.destroy }.to change(ChatRoomUser, :count).by(-1)
    end

    it 'is destroyed when chat_room is destroyed' do
      expect { chat_room.destroy }.to change(ChatRoomUser, :count).by(chat_room.users.count * -1)
    end
  end
end
