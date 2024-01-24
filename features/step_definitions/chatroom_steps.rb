# frozen_string_literal: true

И('я на странице создания новой чат-комнаты') do
  visit new_chat_room_path
end

Когда('я ввожу название чат-комнаты') do
  fill_in 'chat_room_name', with: 'Уютная комната'
end

И('нажимаю кнопку создания чат-комнаты') do
  click_button 'Create'
end

То('я вижу созданную чат-комнату с указанным названием') do
  expect(page).to have_content('Уютная комната')
end

Когда('я не ввожу название чат-комнаты') do
  fill_in 'chat_room_name', with: ''
end

То('я вижу страницу чат-комнаты с автоматически сгенерированным названием') do
  expect(page).to have_content('Chat Room #')
end
