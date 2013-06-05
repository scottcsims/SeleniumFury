module Selenium
  module WebDriver
    class Timeouts

      def initialize(bridge)
        @bridge = bridge
      end

      def implicit_wait
        @implicit_wait || 0
      end

      def implicit_wait=(seconds)
        @bridge.setImplicitWaitTimeout Integer(seconds * 1000)
        @implicit_wait = seconds || 0
      end
    end
  end
end
