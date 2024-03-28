Допустим('зарегистрированы два пользователя') do
  @user1 = User.find_by(email: 'user1@example.com') || FactoryBot.create(:user, email: 'user1@example.com', password: 'password')
  @user2 = User.find_by(email: 'user2@example.com') || FactoryBot.create(:user, email: 'user2@example.com', password: 'password')
end

Когда('первый пользователь создает чат-комнату') do
  in_session("user1") do
    login_as(@user1, scope: :user)
    visit new_chat_room_path
    fill_in 'Name', with: 'Turbo Room'
    click_button 'Create'
  end
end

И('первый пользователь отправляет сообщение "Ты где?" в чат-комнату') do
  in_session("user1") do
    fill_in 'chat-text', with: 'Ты где?!'
    click_button 'Send'
    expect(page).to have_text('Ты где?')
  end
end

И('второй пользователь присоединяется к чат-комнате') do
  in_session("user2") do
    login_as(@user2, scope: :user)
    visit chat_rooms_path
    click_on 'Turbo Room'
  end
end

И('второй пользователь отправляет сообщение "Привет!" в чат-комнату') do
  in_session("user2") do
    fill_in 'chat-text', with: 'Привет!'
    click_button 'Send'
    expect(page).to have_text('Привет!')
    puts "Второй пользователь отправил сообщение"
  end
end

То('первый пользователь видит сообщение "Привет!" в чат-комнате') do
  in_session("user1") do
    expect(page).to have_text('Привет!', wait: 10)
    puts "Первый пользователь видит сообщение"
  end
end
