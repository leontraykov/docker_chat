# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  let(:chat_room) { ChatRoom.new(name: 'Test Room') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(chat_room).to be_valid
    end

    it 'is not valid without a unique name' do
      duplicate_room = chat_room.dup
      chat_room.save
      expect(duplicate_room).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many chat_room_users' do
      expect(ChatRoom.reflect_on_association(:chat_room_users).macro).to eq(:has_many)
    end

    it 'has many users' do
      expect(ChatRoom.reflect_on_association(:users).macro).to eq(:has_many)
    end

    it 'has many messages' do
      expect(ChatRoom.reflect_on_association(:messages).macro).to eq(:has_many)
    end
  end

  describe 'callbacks' do
    it 'sets a default name if none is provided' do
      chat_room.name = nil
      chat_room.valid?
      expect(chat_room.name).to match(/Chat Room #\d{1,3}/)
    end

    it 'broadcasts to chat_rooms after create' do
      expect { chat_room.save }.to have_broadcasted_to('chat_rooms')
    end
  end

  describe 'dependencies' do
    let!(:chat_room_user) { create(:chat_room_user, chat_room:) }
    let!(:message) { create(:message, chat_room:) }

    it 'deletes associated chat_room_users when destroyed' do
      expect { chat_room.destroy }.to change { ChatRoomUser.count }.by(-1)
    end

    it 'deletes associated messages when destroyed' do
      expect { chat_room.destroy }.to change { Message.count }.by(-1)
    end
  end
end
