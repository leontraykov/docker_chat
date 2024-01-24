# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(email: 'test@example.com', password: 'password') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create!(name: 'duplicate', email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
    end

    it 'is not valid with an invalid email format' do
      user.email = 'invalid-email'
      expect(user).not_to be_valid
    end

    it 'assigns a default name if none is provided' do
      user.save!
      expect(user.name).to match(/Speaker #\d{1,3}/)
    end
  end

  describe 'associations' do
    it 'has many chat_rooms' do
      expect(user).to respond_to(:chat_rooms)
    end

    it 'deletes associated messages when destroyed' do
      user.save!
      create(:message, user:)
      expect { user.destroy }.to change(Message, :count).by(-1)
    end
  end

  describe 'callbacks' do
    it 'does not overwrite an existing name' do
      user.name = 'Existing name'
      user.save!
      expect(user.name).to eq('Existing name')
    end

    it 'sets a default name if none is provided' do
      user.save!
      expect(user.name).to match(/Speaker #\d{1,3}/)
    end
  end

  describe 'scopes' do
    it 'does not include user in without_me scope' do
      user.save!
      expect(User.without_me(user)).not_to include(user)
    end
  end
end
