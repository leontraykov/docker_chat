# frozen_string_literal: true

# ApplicationController используется как базовый класс для всех контроллеров в приложении.
# Он включает в себя общие настройки и методы, которые применяются ко всем контроллерам.
class ApplicationController < ActionController::Base
  # Устанавливает фильтр перед действиями в контроллерах Devise для дополнительной настройки параметров.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Разрешает дополнительные параметры при регистрации (sign_up) и обновлении аккаунта (account_update) в Devise.
  # Позволяет принимать атрибут :name при регистрации или обновлении аккаунта.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
