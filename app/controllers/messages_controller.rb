# frozen_string_literal: true

# Контроллер MessagesController управляет действиями, связанными с сообщениями в чате.
class MessagesController < ApplicationController
  # Проверка аутентификации пользователя перед выполнением действий.
  before_action :authenticate_user!
  # Устанавливает чат-комнату для действия create.
  before_action :set_chat_room, only: [:create]

  # Создает новое сообщение в чат-комнате.
  def create
    @message = Message.create_for_chat_room(message_params[:content], current_user, params[:chat_room_id])

    # Ответ в зависимости от успеха сохранения сообщения.
    respond_to do |format|
      if @message.persisted?
        format.turbo_stream
      else
        # В случае неудачи отправляется пустой ответ.
        format.turbo_stream { head :ok }
      end
      # Перенаправление пользователя обратно в чат-комнату.
      format.html { redirect_to chat_room_path(params[:chat_room_id]) }
    end
  end

  private

  # Строгая проверка параметров для сообщения.
  def message_params
    params.require(:message).permit(:content)
  end

  # Устанавливает чат-комнату, в которой будет создано сообщение.
  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end
end
