require 'spec_helper'

RSpec.describe DataMaker::CN::Name do
  describe "#self.first_name" do
    it "generates a valid chinese first name" do
      first_name = described_class.first_name
      validate = DataMaker::Validators::ChineseCharacters.new(first_name)
      expect(validate.valid?).to be_truthy
    end

    context "when number_of_characters is less than 1" do
      it "raises an error" do
        expect { described_class.first_name(rand(0..-3)) }.to raise_error
      end

      context "or number_of_characters is greater than 2" do
        it "raises an error" do
          expect { described_class.first_name(rand(3..5)) }.to raise_error
        end
      end
    end

    context "when number_of_characters is set to 1" do
      it "returns one character" do
        first_name =  described_class.first_name(1)
        expect(first_name.length).to eq(1)
      end
    end
  end

  describe "#self.last_name" do
    it "generates a valid chinese last name" do
      first_name = described_class.first_name
      validate = DataMaker::Validators::ChineseCharacters.new(first_name)
      expect(validate.valid?).to be_truthy
    end
  end

  describe "#self.full_name" do
    it "generates a valid full chinese name" do
      full_name = described_class.full_name
      validate = DataMaker::Validators::ChineseCharacters.new(full_name)
      expect(validate.valid?).to be_truthy
    end

    context "when eastern_format is true" do
      it "reverses the order of the full_name" do
        expect { described_class.full_name(true, rand(0..-3)) }.to raise_error
      end

      context "or eastern_format is false" do
        it "does reverses the order of the full_name" do
          described_class.full_name(true)
        end
      end
    end

    context "when first_name_character_count is less than 1" do
      it "raises an error" do
        expect { described_class.full_name(true, rand(0..-3)) }.to raise_error
      end

      context "or first_name_character_count is greater than 2" do
        it "raises an error" do
          expect { described_class.full_name(true, rand(3..5)) }.to raise_error
        end
      end
    end

  end
end
