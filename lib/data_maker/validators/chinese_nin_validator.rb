module DataMaker
  module Validators
    class ChineseNINValidator
      attr_accessor :nin

      def initialize(nin)
        self.nin = nin
      end

      def self.valid?(*args)
        new(*args).valid?
      end

      def valid?
        raise ArgumentError, "Please pass a NIN to validate!" if nin.nil?
        valid_length? && valid_nin?
      end

      def valid_length?
        nin.length == 18
      end

      def valid_nin?
        checksum = 0
        weights = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
        summod = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2]
        weights.each_with_index do |weight, i|
          checksum += (weight * nin[i].to_i)
        end
        nin[17] == summod[(checksum % 11)].to_s
      end
    end
  end
end
