# frozen_string_literal: true

Допустим('пользователь авторизован и находится в чат-комнате') do
  user = FactoryBot.create(:user, email: 'test@example.com', password: 'password')

  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Login'

  chat_room = FactoryBot.create(:chat_room, name: 'Тестовая Комната')
  visit chat_room_path(chat_room)
end

Когда('пользователь вводит текст сообщения в форму отправки сообщения') do
  fill_in 'chat-text', with: 'Привет, это тестовое сообщение!'
end

Когда('пользователь не вводит текст сообщения в форму отправки сообщения') do
  fill_in 'chat-text', with: ''
end

И('пользователь нажимает кнопку отправки сообщения') do
  click_button 'Send'
end

То('сообщение отображается в чат-комнате') do
  expect(page).to have_content('Привет, это тестовое сообщение!')
end

То('сообщение не сохраняется и не отображается в чат-комнате') do
  expect { click_button 'Send' }.not_to change(Message, :count)
end
