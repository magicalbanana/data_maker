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

      it "generates a valid checksum using DataMaker::CN::GenerateChecksum" do
        nin = generate
        checksum = described_class::GenerateChecksum.new(nin[0..-2])
        expect(checksum.generate).to_not eq(nin[-1])
      end
    end
  end

  describe "::GenerateChecksum" do
    it "generates a checksum per http://en.wikipedia.org/wiki/Resident_Identity_Card#Identity_card_number" do
      expect(described_class::GenerateChecksum.new('123456789012345677').generate).to eq('7')
    end
  end
end
