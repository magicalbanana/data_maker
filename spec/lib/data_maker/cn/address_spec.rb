require 'spec_helper'

RSpec.describe DataMaker::CN::Address do
  describe "#self.street_address" do
    it "calls GenerateAddress#street_address" do
      expect(described_class::GenerateAddress).to receive_message_chain('new.street_address')
      described_class.street_address
    end

    it "returns a string" do
      expect(described_class.street_address).to be_a(::String)
    end
  end

  describe "#self.city" do
    it "returns a city that exists in the file" do
      cities = described_class::CITIES.to_set
      expect(cities).to include(described_class.city)
    end
  end

  describe "#self.province" do
    it "returns a province that exists in the file" do
      provinces = described_class::PROVINCES.to_set
      expect(provinces).to include(described_class.province)
    end
  end

  describe "#self.postal_code" do
    it "returns a postal_code for China" do
      expect(described_class.postal_code).to match(/^([0-9]){6}$/)
    end
  end

  describe "#self.full_address" do
    context "when struct is false" do
      it "returns a string" do
        address = described_class.address(struct: false)
        expect(address).to be_a(::String)
      end
    end

    context "when struct is true" do
      it "returns an OpenStruct" do
        address = described_class.address(struct: true)
        expect(address).to be_a(OpenStruct)
      end
    end
  end

  describe "::GenerateAddress" do
    describe "#initialize" do
      context "when *args is empty" do
        let(:generate_address) { described_class::GenerateAddress.new }

        it "sets options with an empty hash" do
          expect(generate_address.options.empty?).to be_truthy
        end

        it "sets district to nil" do
          expect(generate_address.district.nil?).to be_truthy
        end

        it "sets city to nil" do
          expect(generate_address.city.nil?).to be_truthy
        end

        it "sets province to nil" do
          expect(generate_address.province.nil?).to be_truthy
        end
      end

      context "when args are passed" do
        let(:generate_address) { described_class::GenerateAddress.new(province: 'beijing') }

        it "sets options with passed args" do
          expect(generate_address.options).to include(province: 'beijing')
        end

        it "calls validate" do
          expect_any_instance_of(described_class::GenerateAddress).to receive(:validate)
          generate_address
        end

        context "when province is true" do
          context "but province_exists? is false" do
            let(:generate_address) { described_class::GenerateAddress.new(province: province) }
            let(:province)         { 'illinois' }

            it "raises an ArgumentError" do
              expect { generate_address }.to raise_error(ArgumentError)
            end
          end
        end

        context "when city is true" do
          context "but city_exists? is false" do
            let(:generate_address) { described_class::GenerateAddress.new(city: city) }
            let(:city)             { 'chicago' }

            it "raises an ArgumentError" do
              expect { generate_address }.to raise_error(ArgumentError, "The city #{city} does not exist!")
            end
          end
        end

        context "when district is true" do
          context "but district_exists? is false" do
            let(:generate_address) { described_class::GenerateAddress.new(district: district) }
            let(:district)         { 'dupage' }

            it "raises an ArgumentError" do
              expect { generate_address }.to raise_error(ArgumentError, "The district #{district} does not exist!")
            end
          end
        end

        context "when city.nil? is true" do
          let(:city) { nil }

          before :each do
            #this is self actualizing but this is just to prove that the variable city
            #is indeed nil
            expect(city).to be_nil
          end

          context "and district is true and it exists" do
            let(:generate_address) { described_class::GenerateAddress.new(city: city, district: district) }
            let(:district)         { 'wuwei' }

            it "raises an ArgumentError" do
              expect { generate_address }.to raise_error(ArgumentError, "You must always pass a city with a district!")
            end
          end
        end

        context "when province is true and it exists" do
          let(:province) { 'beijing' }

          before :each do
            provinces = described_class::PROVINCES.to_set
            expect(provinces).to include(province)
          end

          context "and city is true and exists" do
            let(:city) { 'zhaoqing' }

            before :each do
              cities = described_class::CITIES.to_set
              expect(cities).to include(city)
            end

            context "but province_has_city? is false" do
              let(:generate_address) { described_class::GenerateAddress.new(province: province, city: city) }

              it "raises an ArgumentError" do
                expect { generate_address }.to raise_error(ArgumentError, "The province #{province} does not have the city #{city}")
              end
            end
          end
        end

        context "when city is true and it exists" do
          let(:city) { 'beijing' }

          before :each do
            cities = described_class::CITIES.to_set
            expect(cities).to include(city)
          end

          context "and district is true and exists" do
            let(:district) { 'shunde' }

            before :each do
              districts = described_class::DISTRICTS.to_set
              expect(districts).to include(district)
            end

            context "but province_has_city? is false" do
              let(:generate_address) { described_class::GenerateAddress.new(city: city, district: district) }

              it "raises an ArgumentError" do
                expect { generate_address }.to raise_error(ArgumentError, "The city #{city} does not have the district #{district}")
              end
            end
          end
        end
      end
    end

    describe "#generate" do
      context "when options.empty? is true" do
        let(:generate_address) { described_class::GenerateAddress.new }
        let(:province)         { described_class::PROVINCES.sample }

        before :each do
          expect(generate_address.options.empty?).to be_truthy
          allow(generate_address).to receive_message_chain('provinces.sample').and_return(province)
          generate_address.generate
        end

        it "sets province" do
          expect(generate_address.province).to_not be_empty
        end

        it "sets a random province using sample" do
          expect_any_instance_of(described_class::GenerateAddress).to receive_message_chain('provinces.sample')
          generate_address.generate
        end

        it "sets city" do
          expect(generate_address.province).to_not be_empty
        end

        it "sets the city from a province" do
          province_cities = described_class.const_get("#{province}_cities".upcase)
          expect(province_cities.to_set).to include(generate_address.city)
        end

        it "sets district" do
          expect(generate_address.district).to_not be_empty
        end

        it "sets the district from the city" do
          city_districts = described_class.const_get("#{generate_address.city}_districts".upcase)
          expect(city_districts.to_set).to include(generate_address.district)
        end
      end

      context "when options[:province] is true" do
        let(:province)         { described_class::PROVINCES.sample }
        let(:generate_address) { described_class::GenerateAddress.new(province: province) }

        before :each do
          expect(generate_address.options[:province]).to_not be_nil
        end

        context "and options[:city].nil?" do
          before :each do
            expect(generate_address.options[:city]).to be_nil
          end

          context "and options[:district].nil?" do
            before :each do
              expect(generate_address.options[:district]).to be_nil
              generate_address.generate
            end

            it "does not set province again" do
              expect { generate_address.generate }.to_not change { generate_address.province }
            end

            it "sets city" do
              expect(generate_address.province).to_not be_empty
            end

            it "sets the city from a province" do
              province_cities = described_class.const_get("#{province}_cities".upcase)
              expect(province_cities.to_set).to include(generate_address.city)
            end

            it "sets district" do
              expect(generate_address.district).to_not be_empty
            end

            it "sets the district from the city" do
              city_districts = described_class.const_get("#{generate_address.city}_districts".upcase)
              expect(city_districts.to_set).to include(generate_address.district)
            end
          end
        end
      end

      context "when options[:province].nil? is true" do
        let(:city)             { described_class::CITIES.sample }
        let(:generate_address) { described_class::GenerateAddress.new(city: city) }

        before :each do
          expect(generate_address.options[:province]).to be_nil
        end

        context "and options[:city] is true" do
          before :each do
            expect(generate_address.options[:city]).to_not be_nil
          end

          context "and options[:district].nil? is true" do
            before :each do
              expect(generate_address.options[:district]).to be_nil
              generate_address.generate
            end

            it "does not set city again" do
              expect { generate_address.generate }.to_not change { generate_address.city }
            end

            it "sets province using the city's province" do
              cp = nil
              city_provinces = DataMaker::CN::Address::CITY_PROVINCES
              city_provinces.to_set.select do |city_province|
                c, p = city_province.split(",")
                c == generate_address.city ? cp = p : nil
              end
              expect(generate_address.province).to eq(cp)
            end

            it "sets the district from the city" do
              city_districts = described_class.const_get("#{generate_address.city}_districts".upcase)
              expect(city_districts.to_set).to include(generate_address.district)
            end
          end
        end
      end
    end

    describe "#address_string" do
      let(:generate_address) { described_class::GenerateAddress.new }

      it "calls #generate" do
        expect_any_instance_of(described_class::GenerateAddress).to receive(:generate)
        generate_address.address_string
      end

      it "calls #build_address" do
        expect_any_instance_of(described_class::GenerateAddress).to receive(:build_address)
        generate_address.address_string
      end

      it "returns a string" do
        expect(generate_address.address_string).to be_a(::String)
      end
    end

    describe "#address_struct" do
      let(:generate_address) { described_class::GenerateAddress.new }

      it "calls #generate" do
        expect_any_instance_of(described_class::GenerateAddress).to receive(:generate)
        generate_address.address_struct
      end

      it "initiaes a new OpenStruct" do
        expect(OpenStruct).to receive(:new)
        generate_address.address_struct
      end

      it "returns an OpenStruct" do
        expect(generate_address.address_struct).to be_a(OpenStruct)
      end

      it "returns an OpenStruct that responds to street_address" do
        expect(generate_address.address_struct).to respond_to(:street_address)
      end

      it "returns an OpenStruct that responds to city" do
        expect(generate_address.address_struct).to respond_to(:city)
      end

      it "returns an OpenStruct that responds to district" do
        expect(generate_address.address_struct).to respond_to(:district)
      end

      it "returns an OpenStruct that responds to province" do
        expect(generate_address.address_struct).to respond_to(:province)
      end

      it "returns an OpenStruct that responds to postal_code" do
        expect(generate_address.address_struct).to respond_to(:postal_code)
      end
    end
  end
end
