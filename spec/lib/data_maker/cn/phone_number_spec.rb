require 'spec_helper'

RSpec.describe DataMaker::CN::PhoneNumber do
  before :each do
    Phonelib.default_country = 'CN'
  end

  describe "#self.mobile" do
    it "generates a valid mobile_line number" do
      10000.times do
        number = described_class.mobile
        expect(Phonelib.valid?(number)).to be_truthy
      end
    end
  end

  describe "#self.landline" do
    it "generates a valid fixed_line number" do
      10000.times do
        number = described_class.fixed_line
        expect(Phonelib.valid?(number)).to be_truthy
      end
    end
  end
end
