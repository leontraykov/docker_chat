# frozen_string_literal: true

И('я нахожусь в чат-комнате') do
  chat_room = FactoryBot.create(:chat_room, name: 'Тестовая Комната')
  visit chat_room_path(chat_room)
end

Когда('я нажимаю на кнопку выхода в чат-комнате') do
  find('.leave-button').click
end

То('я возвращаюсь на главную страницу') do
  expect(current_path).to eq root_path
end

И('я нахожусь на главной странице') do
  expect(page).to have_content('Welcome')
end
