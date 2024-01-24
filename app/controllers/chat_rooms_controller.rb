# frozen_string_literal: true

class ChatRoomsController < ApplicationController
  before_action :authenticate_user!

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
    @chat_room = ChatRoom.new(chat_room_params)

    if @chat_room.save
      @chat_room.users << current_user
      redirect_to @chat_room, notice: 'Done. Freedom of speech!'
    else
      @users = User.without_me(current_user)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @exact_room = ChatRoom.find_by(id: params[:id])

    if @exact_room.nil?
      redirect_to chat_rooms_path, alert: 'Chat room not found.'
    else
      @room = ChatRoom.new
      @rooms = ChatRoom.all
      @message = Message.new
      @messages = @exact_room.messages.order(created_at: :asc)
      @current_user = current_user
      @users = User.without_me(@current_user)
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name, user_ids: [])
  end
end
