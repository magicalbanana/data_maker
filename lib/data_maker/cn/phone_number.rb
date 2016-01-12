require 'phonelib'

module DataMaker
  module CN
    module PhoneNumber
      extend ModuleUtilities

      def self.mobile
        loop do
          number = PhoneNumberGenerator.generate("mobile")
          break number if Phonelib.valid_for_country?(number, 'CN')
        end
      end

      def self.fixed_line
        loop do
          number = PhoneNumberGenerator.generate("fixed_line")
          break number if Phonelib.valid_for_country?(number, 'CN')
        end
      end

      class PhoneNumberGenerator
        def initialize(format)
          self.format = format
        end

        def self.generate(format)
          inst = new(format)
          inst.generate
        end

        def generate_masks(mask_length = 1)
          raise ArgumentError, "Pass a number greater than 1" if mask_length < 1
          "#" * mask_length
        end

        def generate
          if format == "mobile"
            phone_prefix = mobile_prefix
            max_length = 11
            prefix_length = phone_prefix.length
            mask_length = max_length - prefix_length
          end

          if format == "fixed_line"
            phone_prefix, length = *landline_prefix.split(",")
            mask_length = length.to_i
          end

          masks = generate_masks(mask_length)

          number = [
            phone_prefix,
            masks
          ].join

          DataMaker.numerify(number)
        end

        protected

        attr_accessor :format

        private

        def mobile_prefix
          DataMaker::CN::PhoneNumber::MOBILE_PHONE_PREFIXES.sample
        end

        def landline_prefix
          DataMaker::CN::PhoneNumber::FIXED_LINE_PHONE_PREFIXES.sample
        end
      end
    end
  end
end
