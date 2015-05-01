require 'spec_helper'

RSpec.describe DataMaker do
  let(:masks) { value }

  describe "#VERSION" do
    # For each iteration of a version this would always get changed.
    let(:current_version) { "2.1.3" }

    it { expect(described_class).to be_const_defined(:VERSION) }
    it { expect(described_class::VERSION).to eq(current_version) }
  end

  describe "#self.hexify" do
    let(:regex) { /\b[a-zA-Z0-9]{3}\b/ }

    context "when valid_masks? is true" do
      let(:value) { "### hello ###" }

      it "returns a hexed value" do
        expect(described_class.hexify(*masks)).to match(regex)
      end

      context "when passed an array value" do
        let(:value) { ["hello ###", "my ### is ###"] }

        it "returns a hexed value" do
          expect(described_class.hexify(*masks)).to match(regex)
        end
      end
    end

    context "when valid_masks? raises an error" do
      let(:value) { "hello my name is banana" }

      it "returns false" do
        expect(described_class.hexify(*masks)).to be_falsey
      end
    end
  end

  describe "#self.numerify" do
    let(:regex) { /\b[0-9]{3}\b/ }

    context "when valid_masks? is true" do
      let(:value) { "my phone number is ###" }

      it "returns a numeric value" do
        expect(described_class.numerify(*masks)).to match(regex)
      end

      context "when passed an array value" do
        let(:value) { ["my phone number is ###",  "unit no. ###"] }

        it "returns a numeric value" do
          expect(described_class.numerify(*masks)).to match(regex)
        end
      end
    end

    context "when valid_masks? raises an error" do
      let(:value) { ["my phone number is 3333",  "unit no. seven"] }

      it "returns false" do
        expect(described_class.numerify(*masks)).to be_falsey
      end
    end
  end

  describe "#self.letterify" do
    let(:regex) { /\b[a-z]{3}\b/ }

    context "when valid_masks? is true" do
      let(:value) { "convert me to letters ???" }

      it "returns alphabetic characters" do
        expect(described_class.letterify(*masks)).to match(regex)
      end

      context "when passed an array value" do
        let(:value) { ["convert me ???", "me too ???"] }

        it "returns alphabetic characters" do
          expect(described_class.letterify(*masks)).to match(regex)
        end
      end
    end

    context "when valid_masks? raises an error" do
      let(:value) { "convert me to letters ###" }

      it "returns false" do
        expect(described_class.letterify(*masks)).to be_falsey
      end
    end
  end

  describe "#self.alphanumerify" do
    let(:regex) { /\b[a-zA-Z0-9]{3}\b/ }

    context "when valid_masks? is true" do
      let(:value) { "alphanumerify me ##?" }

      it "returns alphanumeric characters" do
        expect(described_class.alphanumerify(*masks)).to match(regex)
      end
    end

    context "when valid_masks? raises an error" do
      let(:value) { "I am not correct" }

      it "returns false" do
        expect(described_class.alphanumerify(*masks)).to be_falsey
      end
    end
  end

  # PRIVATE
  describe "#valid_mask?" do
    context "if mask.match(match_with) is not nil" do
      let(:masks) { ["Apt. #" "##",  "Banana Street No. ###"] }
      let(:match_with) { /#/ }

      it "returns true" do
        expect(described_class.send(:valid_mask?, *masks, match_with)).to be_truthy
      end
    end

    context "if mask is not equal to '#'" do
      let(:masks) { ["###", "#" "abc @", "!"] }
      let(:match_with) { /\?/ }

      it "raises an error" do
        expect { described_class.send(:valid_mask?, *masks, match_with) }.to raise_error
      end
    end
  end
end
