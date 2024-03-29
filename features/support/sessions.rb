# frozen_string_literal: true

module Capybara
  module Driver
    module Sessions
      def set_session(id)
        $sessions ||= {}
        $sessions[id] = Capybara::Session.new(Capybara.current_driver, Capybara.app) unless $sessions[id]
        Capybara.session_name = id
      end

      def in_session(id)
        old_session_name = Capybara.session_name
        set_session(id)
        yield
      ensure
        Capybara.session_name = old_session_name
      end
    end
  end
end

World(Capybara::Driver::Sessions)
