module DataMaker
  module CN
    module Name
      extend ModuleUtilities

      def self.first_name(number_of_characters = 2)
        if number_of_characters < 1 || number_of_characters > 2
          raise ArgumentError, "You can only pass 1 or 2" 
        end
        first_name = FIRST_NAMES.sample
        if number_of_characters < 2
          return first_name[0].slice(0)
        end
        first_name
      end

      def self.last_name
        LAST_NAMES.sample
      end

      def self.full_name(eastern_format = true, first_name_character_count = 2)
        if first_name_character_count < 1 || first_name_character_count > 2
          raise ArgumentError, "You can only pass 1 or 2" 
        end
        full_name = []
        full_name << first_name(first_name_character_count)
        full_name << last_name
        eastern_format ? full_name.reverse : full_name
        full_name.join
      end
    end
  end
end
