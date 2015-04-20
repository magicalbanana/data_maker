module RSpec
  module Matchers
    def have_valid_chinese_mobile

    end

    def have_valid_chinese_landline

    end

    class PhoneNumberMatcher
      def initialize(phone_number)
        self.phone_number = phone_number
      end

      def matches?(actual)

      end

      def description

      end

      def failure_message

      end

      def failure_message_when_negated

      end

      protected

      def actual=(actual)
        self.actual = actual
      end

      attr_reader :actual
      attr_accessor :phone_number, :validator
    end
  end
end
