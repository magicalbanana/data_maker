module DataMaker
  module Validators
    class ChineseCharacters

      CJK_CHARACTER_RANGES = [ { min: "4E00",  max: "9FFF",  comment: "Common" },
                               { min: "3400",  max: "4DFF",  comment: "Rare" },
                               { min: "20000", max: "2A6DF", comment: "Rare, historic" },
                               { min: "F900",  max: "FAFF",  comment: "Duplicates, unifiable variants" },
                               { min: "2F800", max: "2FA1F", comment: "unifiable variants" },
                               { min: "AC00",  max: "D7AF",  comment: "Hangul syllables" } ]

      def initialize(characters)
        @characters = characters
      end

      def valid?
        valid_characters = true
        @characters.each_char do |character|
          hex_chinese = "%04x" % character[0].ord
          valid_characters = true unless within_cjk_range(hex_chinese)
        end
      end

      private

      def within_cjk_range(hex_string)
        val = hex_string.hex
        CJK_CHARACTER_RANGES.each do |valid_range|
          return true if val >= valid_range[:min].hex && val <= valid_range[:max].hex
        end

        return false
      end
    end
  end
end
