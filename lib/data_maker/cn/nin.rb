module DataMaker
  module CN
    module NIN
      extend ModuleUtilities

      def self.national_id_number
        nin = GenerateNationalIDNumber.new
        nin.generate
      end

      class GenerateNationalIDNumber
        def generate
          nin = national_id_number
          # while DataMaker::Validators::ChineseNINValidator.valid?(nin)
          #   nin = national_id_number
          #   break if DataMaker::Validators::ChineseNINValidator.valid?(nin)
          # end
          nin
        end

        private

        def national_id_number
          birthdate = rand(1920..1998).to_s + rand(1..12).to_s.rjust(2, '0') + rand(1..30).to_s.rjust(2, '0')
          base_number = rand(10 ** 6).to_s.rjust(6, '0') + birthdate + rand(10 ** 3).to_s.rjust(3, '0')
          weights = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
          summod = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2]
          checksum = 0
          weights.each_with_index do |weight, i|
            checksum += (weight * base_number[i].to_i)
          end
          base_number + summod[(checksum % 11)].to_s
        end
      end
    end
  end
end
