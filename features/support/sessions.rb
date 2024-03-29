# frozen_string_literal: true

module Capybara
  module Driver
    # Модуль Sessions предоставляет функциональность для управления сессиями в Capybara.
    module Sessions
      # Инициализирует или возвращает сессию Capybara для указанного идентификатора.
      def init_session(id)
        @sessions ||= {}
        @sessions[id] = Capybara::Session.new(Capybara.current_driver, Capybara.app) unless @sessions[id]
        Capybara.session_name = id
      end

      # Выполняет блок кода в контексте сессии с указанным идентификатором.
      def in_session(id)
        old_session_name = Capybara.session_name
        init_session(id)
        yield
      ensure
        Capybara.session_name = old_session_name
      end
    end
  end
end

# Добавляет функциональность модуля Sessions в глобальный контекст Capybara.
World(Capybara::Driver::Sessions)
