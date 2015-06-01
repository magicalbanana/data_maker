module DataMaker
  module CN
    module NIN
      extend ModuleUtilities

      def self.national_id_number
        nin = GenerateNationalIDNumber.new
        nin.generate
      end

      class GenerateNationalIDNumber
        attr_accessor :birthdate, :base_number, :checksum

        def initialize
          self.birthdate = generate_birthdate
        end

        def generate
          base_number + DataMaker::CN::NIN::GenerateChecksum.new(base_number).generate
        end

        def base_number
          self.base_number = rand(10 ** 6).to_s.rjust(6, '0') + birthdate + rand(10 ** 3).to_s.rjust(3, '0')
        end

        private

        def generate_birthdate
          rand(1920..1998).to_s + rand(1..12).to_s.rjust(2, '0') + rand(1..30).to_s.rjust(2, '0')
        end
      end

      class GenerateChecksum
        attr_accessor :base_number

        def initialize(base_number)
          self.base_number = base_number
        end

        def generate
          weights = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
          summod  = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2]
          checksum = 0
          weights.each_with_index do |weight, index|
            checksum += (weight.to_i * base_number[index].to_i)
          end
          summod[(checksum % 11)].to_s
        end
      end
    end
  end
end
