module DataMaker
  module CN
    module Address
      extend ModuleUtilities

      def self.street_address(params)
        const_get(params.upcase)
      end

      def self.street_name
      end

      def self.unit_no
      end

      def self.city
      end

      def self.province
      end

      def self.postcode
      end

      def self.full_address(province: nil, city: nil, district: nil)
      end

      class AddressGenerator
        def initialize(province, city, district)
          @province = province
          @city = city
          @district = district
        end

        def street_address
        end

        def street_name
        end

        def city
        end

        def unit_no
          masks = "#" * rand(1..5)
          DataMaker.numerify(masks)
        end

        def postal_code
        end

        def province
        end
      end
    end
  end
end
