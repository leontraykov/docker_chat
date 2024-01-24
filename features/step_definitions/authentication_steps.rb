# frozen_string_literal: true

Допустим('я авторизован как пользователь') do
  @user = FactoryBot.create(:user, email: 'test@example.com', password: 'password')
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: 'password'
  click_button 'Login'
end
