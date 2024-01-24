# frozen_string_literal: true

И('я на главной странице') do
  visit root_path
end

Когда('я выбираю существующий чат-рум из списка') do
  unique_chat_room_name = "Тестовая Комната #{Time.now.to_i}"
  FactoryBot.create(:chat_room, name: unique_chat_room_name)
  visit root_path
  find('.chatroom-link', text: unique_chat_room_name).click
end

То('я успешно вхожу в чат-рум') do
  expect(page).to have_current_path(chat_room_path(ChatRoom.last))
end

И('вижу поле ввода сообщения') do
  expect(page).to have_content('Send')
end
