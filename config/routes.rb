# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users

  root 'chat_rooms#index'
  resources :chat_rooms, only: %i[index new create show] do
    resources :messages, only: [:create]
  end
end
