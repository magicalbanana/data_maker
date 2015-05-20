module DataMaker
  module CN
    module Address
      extend ModuleUtilities

      def self.street_address
        GenerateAddress.new.street_address
      end

      def self.city(province = nil)
        address = GenerateAddress.new(province: province)
        address.generate
        address.city
      end

      def self.province(city = nil)
        address = GenerateAddress.new(city: city)
        address.generate
        address.province
      end

      def self.postal_code(province = nil)
        address = GenerateAddress.new(province: province)
        address.generate
        address.postal_code
      end

      def self.address(province: nil, city: nil, district: nil, struct: false)
        address  = GenerateAddress.new(province: province, city: city, district: district)
        struct ? address.address_struct : address.address_string
      end

      class GenerateAddress
        attr_accessor :province, :city, :district, :street_address, :locale, :options

        def initialize(*args)
          self.options  = (args.last.is_a?(::Hash) ? args.last : {}).delete_if { |k, v| v.nil? }
          self.district = options[:district]
          self.city     = options[:city]
          self.province = options[:province]
          self.locale   = options[:locale] || :zh
          unless options.empty?
            validate
          end
        end

        def generate
          if options.empty?
            # Generate a random address from a province
            self.province = provinces.sample
            self.city     = province_cities.sample
            self.district = city_districts.nil? ? nil : city_districts.sample
          end

          if options[:province] && options[:city].nil? && options[:district].nil?
            self.city     = province_cities.sample
            self.district = city_districts.nil? ? nil : city_districts.sample
          end

          if options[:province].nil? && options[:city] && options[:district].nil?
            self.province = city_province
            self.district = city_districts.nil? ? nil : city_districts.sample
          end
        end

        def street_address
          [unit_no, street_name, street_suffix].join
        end

        def address_string
          generate
          build_address
        end

        def address_struct
          generate
          OpenStruct.new(street_address: street_address,
                         city:           translate('city', city),
                         district:       (translate('district', district) unless district.nil?),
                         province:       translate('province', province),
                         postal_code:    postal_code
                        )
        end

        def postal_code
          postal_code = nil
          province_postal_codes = DataMaker::CN::Address::PROVINCE_POSTAL_CODES
          province_postal_codes.to_set.select do |province_postal_code|
            p, pc = province_postal_code.split(",")
            p == province ? postal_code = pc : nil
          end
          postal_code
        end

        private

        def translate(prefix, value)
          DataMaker::Config.locale = locale
          DataMaker.translate(['data_maker', 'address', prefix, value].join("."))
        end

        def validate
          if province
            unless province_exists?
              raise ArgumentError, "The province #{province} does not exist!"
            end
          end

          if city
            unless city_exists?
              raise ArgumentError, "The city #{city} does not exist!"
            end
          end

          if district
            unless district_exists?
              raise ArgumentError, "The district #{district} does not exist!"
            end
          end

          if city.nil? && district
            raise ArgumentError, "You must always pass a city with a district!"
          end

          if province && city
            unless province_has_city?
              raise ArgumentError, "The province #{province} does not have the city #{city}"
            end
          end

          if city && district
            unless city_has_district?
              raise ArgumentError, "The city #{city} does not have the district #{district}"
            end
          end
        end

        def provinces
          DataMaker::CN::Address::PROVINCES
        end

        def cities
          DataMaker::CN::Address::CITIES
        end

        def districts
          DataMaker::CN::Address::DISTRICTS
        end

        def build_address
          address = []
          address << street_address
          address << translate('city', city)
          address << translate('district', district) unless district.nil?
          address << translate('province', province)
          address << postal_code
          address.compact.join(", ")
        end

        def street_name
          DataMaker::CN::Name::LAST_NAMES.sample
        end

        def street_suffix
          DataMaker::CN::Address::STREET_SUFFIXES.sample
        end

        def unit_no
          masks = "#" * rand(1..2)
          DataMaker.numerify(masks)
        end

        def city_districts
          raise ArgumentError, "Please pass a city!" if city.nil?
          d = DataMaker::CN::Address.const_get("#{city}_districts".upcase)
          d.empty? ? nil : d
        end

        def city_province
          province = nil
          city_provinces = DataMaker::CN::Address::CITY_PROVINCES
          city_provinces.to_set.select do |city_province|
            c, p = city_province.split(",")
            c == city ? province = p : nil
          end
          province
        end

        def province_cities
          raise ArgumentError, "Please pass a province!" if province.nil?
          DataMaker::CN::Address.const_get("#{province}_cities".upcase)
        end

        def province_exists?
          provinces.to_set.include?(province)
        end

        def city_exists?
          cities.to_set.include?(city)
        end

        def district_exists?
          districts.to_set.include?(district)
        end

        def province_has_city?
          province_cities.to_set.include?(city)
        end

        def city_has_district?
          city_districts.to_set.include?(district)
        end
      end
    end
  end
end
