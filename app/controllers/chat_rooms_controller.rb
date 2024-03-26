# frozen_string_literal: true

class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exact_room, only: [:show]

  def index
    @chat_rooms = ChatRoom.all
    @users = User.without_me(current_user)
    @user = current_user
  end

  def new
    @chat_room = ChatRoom.new
    @users = User.without_me(current_user)
  end

  def create
    @chat_room = ChatRoom.create_with_user(chat_room_params, current_user)

    if @chat_room.persisted?
      redirect_to @chat_room, notice: 'Done. Freedom of speech!'
    else
      @users = User.without_me(current_user)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    if @exact_room.nil?
      redirect_to chat_rooms_path, alert: 'Chat room not found.'
    else
      set_additional_resources
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name, user_ids: [])
  end

  def set_exact_room
    @exact_room = ChatRoom.find_by(id: params[:id])
  end

  def set_additional_resources
    @room = ChatRoom.new
    @rooms = ChatRoom.all
    @message = Message.new
    @messages = @exact_room.messages.order(created_at: :asc)
    @users = User.without_me(current_user)
  end
end
