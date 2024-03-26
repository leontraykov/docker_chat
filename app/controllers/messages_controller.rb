# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room, only: [:create]

  def create
    @message = Message.create_for_chat_room(message_params[:content], current_user, params[:chat_room_id])

    respond_to do |format|
      if @message.persisted?
        format.turbo_stream
      else
        format.turbo_stream { head :ok }
      end
      format.html { redirect_to chat_room_path(params[:chat_room_id]) }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def build_message
    current_user.messages.new(content: message_params[:content], chat_room_id: @chat_room.id)
  end
end
