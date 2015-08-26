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
          birthdate = time_rand
          birthdate_string = birthdate.year.to_s + birthdate.month.to_s.rjust(2, '0') + birthdate.day.to_s.rjust(2, '0')
          base_number = rand(10 ** 6).to_s.rjust(6, '0') + birthdate_string + rand(10 ** 3).to_s.rjust(3, '0')
          weights = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2]
          summod = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2]
          checksum = 0
          weights.each_with_index do |weight, i|
            checksum += (weight * base_number[i].to_i)
          end
          base_number + summod[(checksum % 11)].to_s
        end

        def time_rand from = 0.0, to = Time.new(1998)
          Time.at(from + rand * (to.to_f - from.to_f))
        end
      end
    end
  end
end
