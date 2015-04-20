module DataMaker
  module Validators
    class ChinesePhoneNumber
      def initialize(number)
        @number = number
      end

      def mobile?
        mobile_regex = /^1[34578]\d(\D?)\d{4}(\D?)\d{4}$/
        !(mobile_regex.match(@number.to_s).nil?)
      end

      def landline?
        twodigit = /^0?((10)|(2[0-57-9])|(3[157])|(4[17])|(5[1,3,5])|(7[1579])|(8[357])|(9[379]))\d{8,9}$/
        threedigit = /^0?(((335|349|39[1-6]|398))|((42[179]|43[1-9]|44[08]|45[1-9]|46[4789]|48[23]))|((52[37]|54[36]|56[1-6]|580|59[1-9]))|((63[1-5]|66[0238]|69[12]))|((701|72[248]|73[014-9]|74[3-6]|76[023689]))|((81[23678]|82[5-7]|88[136-8]|89[1-8]))|((90[123689]|91[1-9]|94[13]|95[1-5])))\d{7,}$/
          fourdigit = /^0?((8029|806[03578]|807[01])\d{6,})$/

          !(twodigit.match(@number.to_s).nil?) ||
          !(threedigit.match(@number.to_s).nil?) ||
          !(fourdigit.match(@number.to_s).nil?)
      end

      def valid?
        mobile? || landline?
      end
    end
  end
end
