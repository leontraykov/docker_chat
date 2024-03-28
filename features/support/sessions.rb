module Capybara
  module Driver
    module Sessions
      def set_session(id)
        $sessions ||= {}
        unless $sessions[id]
          $sessions[id] = Capybara::Session.new(Capybara.current_driver, Capybara.app)
        end
        Capybara.session_name = id
      end

      def in_session(id, &block)
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
