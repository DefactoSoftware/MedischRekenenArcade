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
    it "should return difficulty 1" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([0,0])).to eq(1)
    end

    it "should return difficulty 1" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([1,1])).to eq(1)
    end

    it "should return difficulty 1" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([0,1])).to eq(1)
    end

    it "should return difficulty 1" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([1,0])).to eq(1)
    end

    it "should return difficulty 3" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([2,1])).to eq(3)
    end

    it "should return difficulty 2" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([4,2])).to eq(2)
    end

    it "should return difficulty 3" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([4,3])).to eq(3)
    end

    it "should return difficulty 10" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([100,1])).to eq(10)
    end

    it "should return difficulty 22" do
      expect(MathDifficultyHelper.compute_subtraction_difficulty([5000007,9])).to eq(22)
    end
  end

  describe "#compute_addition_difficulty" do
    it "should return 1" do
      expect(MathDifficultyHelper.compute_addition_difficulty([0,0])).to eq(1)
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_addition_difficulty([0,1])).to eq(1)
    end

    it "should return 2" do
      expect(MathDifficultyHelper.compute_addition_difficulty([1,1])).to eq(2)
    end

    it "should return 3" do
      expect(MathDifficultyHelper.compute_addition_difficulty([1,2])).to eq(3)
    end

    it "should return 2" do
      expect(MathDifficultyHelper.compute_addition_difficulty([2,2])).to eq(2)
    end

    it "should return 5" do
      expect(MathDifficultyHelper.compute_addition_difficulty([19,9])).to eq(5)
    end

    it "should return 22" do
      expect(MathDifficultyHelper.compute_addition_difficulty([99999,12345])).to eq(22)
    end
  end
end
