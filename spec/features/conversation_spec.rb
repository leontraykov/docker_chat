require 'rails_helper'

RSpec.feature "Chat functionality", type: :feature, js: true do
  scenario "User creates a chat room and another user joins and sends a message" do
    
    unless User.find_by(email: 'user_1@ex.co').present?
      user1 = User.create!(name: "user_1", email: "user_1@ex.co", password: "password")
      user2 = User.create!(name: "user_2", email: "user_2@ex.co", password: "password")
    end

    in_browser(:one) do
      login_as(user1, scope: :user)
      visit new_chat_room_path
      fill_in "Name", with: "Chat Room 1"
      click_button "Create"
      expect(page).to have_text("Chat Room 1")
    end

    in_browser(:two) do
      login_as(user2, scope: :user)
      visit chat_rooms_path
      click_button "Chat Room 1"
      fill_in "chat-text", with: "Привет"
      click_button "Send"
    end

    in_browser(:one) do
      expect(page).to have_text("Привет")
    end
  end

  def in_browser(name)
    old_session = Capybara.session_name

    Capybara.session_name = name
    yield

    Capybara.session_name = old_session
  end
end
