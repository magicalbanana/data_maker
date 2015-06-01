module DataMaker
  module Validators
    class ChineseNINValidator
      attr_accessor :nin

      def initialize(nin)
        self.nin = nin
      end

      def valid?
        raise ArgumentError, "Please pass a NIN to validate!" if nin.nil?
        valid_length? && valid_checksum?
      end

      def valid_length?
        nin.length == 18
      end

      def valid_checksum?
        DataMaker::CN::NIN::GenerateChecksum.new(nin[0..-2]).generate == nin[-1]
      end
    end
  end
end
