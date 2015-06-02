require 'spec_helper'

RSpec.describe DataMaker::CN::NIN do
  describe "#self.national_id_number" do
    it "calls DataMaker::CN::GenerateNationalIDNumber#generate" do
      expect_any_instance_of(described_class::GenerateNationalIDNumber).to receive(:generate)
      described_class.national_id_number
    end
  end

  describe "::GenerateNationalIDNumber" do
    describe "#initialize" do
      let(:param) { rand(1000..2000) }

      it "raises an error when a parameter is passed" do
        expect { described_class::GenerateNationalIDNumber.new(param) }.to raise_error
      end
    end

    describe "#generate" do
      let(:generate) { described_class::GenerateNationalIDNumber.new.generate }

      it "generates a string with a length of 18" do
        expect(generate.length).to eq(18)
      end

      it "generates a valid national id number" do
        nin = generate
        expect(DataMaker::Validators::ChineseNINValidator.valid?(nin)).to be_truthy
      end
    end
  end
end
