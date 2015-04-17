require 'spec_helper'

RSpec.describe Forge::ArrayUtilities do
  let(:array_utilities) { described_class }

  describe "#self.const_array" do
    let(:self_const_array) { array_utilities.const_array(argument) }
    let(:argument) { ["a".."z"] }

    context "when the object is not an array" do
      let(:argument) { "a".."z" }

      it "converts it to an array" do
        expect(self_const_array).to be_a(Array)
      end
    end

    it "freezes the array" do
      array = self_const_array
      expect(array.frozen?).to be_truthy
    end

    it "freezes the array elements" do
      array = self_const_array
      array.each do |a|
        expect(a.frozen?).to be_truthy
      end
    end
  end

  describe "#self.random_pick" do
    let(:random_pick) { array_utilities.random_pick(array, n) }
    let(:array) { [*"a".."z"] }
    let(:elements) { Set.new("a".."z") }
    let(:n) { rand(1..5) }

    it "randomly picks n number of elements" do
      rand(1000..9999).times do
        randomly_picked_elements = random_pick
        expect(randomly_picked_elements.length).to eq(n)
      end
    end

    it "randomly picks elements in the specified array" do
      randomly_picked_elements = random_pick
      rand(1000..9999).times do
        randomly_picked_elements.each do |element|
          expect(elements).to include(element)
        end
      end
    end
  end

  describe "#self.freeze_all" do
    let(:freeze_all) { array_utilities.freeze_all(array) }
    let(:array) { [*"a".."z"] }

    it "freezes the array" do
      array = freeze_all
      expect(array.frozen?).to be_truthy
    end

    it "freezes the array elements" do
      array = freeze_all
      array.each do |a|
        expect(a.frozen?).to be_truthy
      end
    end
  end

  describe "#self.shuffle" do
    let(:shuffle) { array_utilities.shuffle(array) }
    let(:array) { [*"a".."z"] }
    let(:elements) { Set.new("a".."z") }

    it "shuffles the array" do
      different_sort = 0
      rand(1000..9999).times do
        shuffled_array = shuffle
        different_sort += 1 if shuffled_array != array
      end
      expect(different_sort).to satisfy { |value| value > 0 }
    end

    it "shuffles the array without adding/removing elements" do
      rand(1000..9999).times do
        shuffled_array = shuffle
        expect(shuffled_array.to_set).to eq(elements)
      end
    end
  end

  describe "#random_pick" do
  end

  describe "#freeze_all" do
  end

  describe "#shuffle" do
  end
end
