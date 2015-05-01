module DataMaker
  module CN
    module PhoneNumber
      extend ModuleUtilities

      def self.mobile
        number = PhoneNumberGenerator.new("mobile")
        number.generate
      end

      def self.landline
        number = PhoneNumberGenerator.new("landline")
        number.generate
      end

      def self.phone_number
      end

      class PhoneNumberGenerator
        def initialize(format)
          self.format = format
        end

        def mobile_prefix
          prefix = DataMaker::CN::PhoneNumber::MOBILE_PHONE_PREFIXES.sample
          raise StandardError, "You're file is empty!" if prefix.length == 0
          prefix
        end

        def landline_prefix
          prefix = DataMaker::CN::PhoneNumber::LANDLINE_PHONE_PREFIXES.sample
          raise StandardError, "You're file is empty!" if prefix.length == 0
          prefix
        end

        def generate_masks(mask_length = 1)
          raise ArgumentError, "Pass a number greater than 1" if mask_length < 1
          "#" * mask_length
        end

        def generate
          if format == "mobile"
            phone_prefix = mobile_prefix
            phone_number_max_length = 11
            prefix_length = phone_prefix.length
            mask_length = phone_number_max_length - prefix_length
          end

          if format == "landline"
            phone_prefix = landline_prefix
            phone_number_max_length = eleven_digit_rule?(phone_prefix) ? 11 : 10
            prefix_length = phone_prefix.length
            mask_length = phone_number_max_length - prefix_length
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

        def eleven_digit_rule?(prefix)
          [
            '10',
            '311',
            '371',
            '377',
            '379',
            '411',
            '431',
            '432',
            '451',
            '510',
            '512',
            '513',
            '515',
            '516',
            '519',
            '527',
            '531',
            '532',
            '551',
            '571',
            '573',
            '577',
            '579',
            '591',
            '595',
            '731',
            '754',
            '755',
            '757',
            '760',
            '769',
            '791',
            '851',
            '871',
            '898'
          ].include?(prefix)
        end
      end
    end
  end
end
