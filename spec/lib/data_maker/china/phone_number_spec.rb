require 'spec_helper'

RSpec.describe DataMaker::China::PhoneNumber do
  let(:phone_number) { described_class }

  describe "#self.mobile" do
    it "generates a valid mobile number" do
      number = phone_number.mobile
      validate = DataMaker::Validators::ChinesePhoneNumber.new(number)
      expect(validate.valid?).to be_truthy
    end
  end

  describe "#self.landline" do
  end

  describe "::GeneratePhoneNumber" do
    let(:generate_phone_number) { described_class::PhoneNumberGenerator.new(format) }
    let(:format) { ["mobile", "landline"].sample }

    describe "#mobile_prefix" do
      let(:mobile_prefix) { generate_phone_number.mobile_prefix }

      # context "when MobilePhonePrefix.empty? is true" do
      #   before :each do
      #   end

      #   it "raises an error" do
      #     expect { mobile_prefix }.to raise_error
      #   end
      # end

      context "when MobilePhonePrefix.empty? is false" do
        it "returns a sample" do
          expect(mobile_prefix).to_not be_empty
        end
      end
    end

    describe "#generate_number" do
      let(:generate) { generate_phone_number.generate }

      # it "generates a valid phone number" do
      #   number = generate
      #   validate = DataMaker::Validators::ChinesePhoneNumber.new(number)
      #   expect(validate.valid?).to be_truthy
      # end

      context "when format is mobile" do
        let(:format) { "mobile" }

        it "generates an 11 digit number" do
          expect(generate.length).to eq(11)
        end
      end

      context "when format is landline" do
        let(:format) { "landline" }

        context "when eleven_digit_rule? is true" do
          before :each do
            allow(generate_phone_number).to receive(:eleven_digit_rule?).and_return(true)
          end

          it "generates an 11 digit number" do
            expect(generate.length).to eq(11)
          end
        end

        context "when eleven_digit_rule? is false" do
          before :each do
            allow(generate_phone_number).to receive(:eleven_digit_rule?).and_return(false)
          end

          it "generates an 10 digit number" do
            expect(generate.length).to eq(10)
          end
        end
      end
    end
  end
end
