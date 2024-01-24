# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:chat_room) { create(:chat_room) }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new message and redirects' do
        post_params = {
          chat_room_id: chat_room.id,
          message: { content: 'Hello, world!' }
        }
        expect do
          post :create, params: post_params
        end.to change(Message, :count).by(1)
        expect(response).to redirect_to(chat_room_path(chat_room))
      end
    end

    context 'with invalid parameters' do
      it 'redirects back to chat room without creating a message' do
        post_params = {
          chat_room_id: chat_room.id,
          message: { content: '' }
        }
        expect do
          post :create, params: post_params
        end.not_to change(Message, :count)
        expect(response).to redirect_to(chat_room_path(chat_room))
      end
    end

    context 'with non-existent chat room' do
      it 'handles ActiveRecord::RecordNotFound' do
        expect do
          post :create, params: { chat_room_id: 'non-existent', message: { content: 'Hello, world!' } }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'Authentication' do
    before { sign_out user }

    it 'redirects non-logged in user from creating a message' do
      post_params = {
        chat_room_id: chat_room.id,
        message: { content: 'Test message' }
      }
      post :create, params: post_params
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
