require 'spec_helper'
include MathDifficultyHelper

describe "MathDifficultyHelper" do
  describe "#is_even" do
    it "should return true when number is even" do
      expect(MathDifficultyHelper.is_even(2)).to eq(true)
    end

    it "should return false when number is odd" do
      expect(MathDifficultyHelper.is_even(3)).to eq(false)
    end
  end

  describe "#compute_subtraction_difficulty" do
    it "should return [0,1]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([0,0])).to eq([0,1])
    end

    it "should return [0,1]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([1,1])).to eq([0,1])
    end

    it "should return [-1,1]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([0,1])).to eq([1,1])
    end

    it "should return [1,1]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([1,0])).to eq([1,1])
    end

    it "should return [1,3]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([2,1])).to eq([1,3])
    end

    it "should return [2,2]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([4,2])).to eq([2,2])
    end

    it "should return [1,3]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([4,3])).to eq([1,3])
    end

    it "should return [100,1]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([100,1])).to eq([99,10])
    end

    it "should return [4999998, 22]" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([5000007,9])).to eq([4999998,22])
    end
  end
end
