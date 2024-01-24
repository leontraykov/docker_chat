# frozen_string_literal: true

user_data = [
  { name: 'user_1', email: 'user_1@ex.co', password: 'user_1_password', password_confirmation: 'user_1_password' },
  { name: 'user_2', email: 'user_2@ex.co', password: 'user_2_password', password_confirmation: 'user_2_password' },
  { name: 'user_3', email: 'user_3@ex.co', password: 'user_3_password', password_confirmation: 'user_3_password' }
]

users = user_data.map do |attributes|
  User.find_or_create_by!(email: attributes[:email]) do |user|
    user.name = attributes[:name]
    user.password = attributes[:password]
    user.password_confirmation = attributes[:password_confirmation]
  end
end

chat_rooms = ChatRoom.create!([
                                { name: 'user_1 + user_2 Chatroom' },
                                { name: 'user_2 + user_3 Chatroom' },
                                { name: 'Common Chatroom' }
                              ])

chat_room_users_data = [
  { chat_room: chat_rooms[0], user: users[0] },
  { chat_room: chat_rooms[0], user: users[1] },
  { chat_room: chat_rooms[1], user: users[1] },
  { chat_room: chat_rooms[1], user: users[2] },
  { chat_room: chat_rooms[2], user: users[0] },
  { chat_room: chat_rooms[2], user: users[1] },
  { chat_room: chat_rooms[2], user: users[2] }
]

chat_room_users_data.each do |chat_room_user_attributes|
  ChatRoomUser.find_or_create_by!(chat_room_user_attributes)
end
