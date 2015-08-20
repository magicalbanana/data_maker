require 'spec_helper'

RSpec.describe DataMaker::CN::Employment do
  describe "#self.job_title" do
    it "generates a job title in chinese" do
      job_title = described_class.job_title
      validate = DataMaker::Validators::ChineseCharacters.new(job_title)
      expect(validate.valid?).to be_truthy
    end
  end
end
