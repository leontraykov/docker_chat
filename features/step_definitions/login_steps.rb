# frozen_string_literal: true

Допустим('я пользователь с электронной почтой {string} и паролем {string}') do |email, password|
  User.create!(email:, password:, password_confirmation: password)
end

Когда('я перехожу на страницу входа') do
  visit new_user_session_path
end

И('я не авторизован') do
end

И('я ввожу в поле {string} значение {string}') do |field, value|
  fill_in field, with: value
end

И('я нажимаю на кнопку {string}') do |button_name|
  click_button button_name
end

То('я должен увидеть {string}') do |expected_text|
  expect(page).to have_text(expected_text)
end
