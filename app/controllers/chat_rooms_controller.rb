# frozen_string_literal: true

# Контроллер ChatRoomsController управляет действиями, связанными с чат-комнатами.
class ChatRoomsController < ApplicationController
  # Проверка аутентификации пользователя перед выполнением действий.
  before_action :authenticate_user!
  # Устанавливает чат-комнату для действия show.
  before_action :set_exact_room, only: [:show]

  # Отображает список всех чат-комнат и доступных пользователей.
  def index
    @chat_rooms = ChatRoom.all
    @users = User.without_me(current_user)
    @user = current_user
  end

  # Инициализирует создание новой чат-комнаты.
  def new
    @chat_room = ChatRoom.new
    @users = User.without_me(current_user)
  end

  # Создает новую чат-комнату с участием текущего пользователя.
  def create
    @chat_room = ChatRoom.create_with_user(chat_room_params, current_user)

    if @chat_room.persisted?
      redirect_to @chat_room, notice: 'Чат создан. Свобода слова!'
    else
      @users = User.without_me(current_user)
      render :new, status: :unprocessable_entity
    end
  end

  # Показывает конкретную чат-комнату, если она существует.
  def show
    if @exact_room.nil?
      redirect_to chat_rooms_path, alert: 'Чат-комната не найдена.'
    else
      set_additional_resources
    end
  end

  private

  # Параметры для создания или обновления чат-комнаты.
  def chat_room_params
    params.require(:chat_room).permit(:name, user_ids: [])
  end

  # Устанавливает конкретную чат-комнату по ID.
  def set_exact_room
    @exact_room = ChatRoom.find_by(id: params[:id])
  end

  # Устанавливает дополнительные ресурсы для действия show.
  def set_additional_resources
    @room = ChatRoom.new
    @rooms = ChatRoom.all
    @message = Message.new
    @messages = @exact_room.messages.order(created_at: :asc)
    @users = User.without_me(current_user)
  end
end
