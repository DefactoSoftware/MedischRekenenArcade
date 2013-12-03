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
      expect(MathDifficultyHelper.compute_addition_difficulty([0,0])).to eq([0,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_addition_difficulty([0,1])).to eq([1,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_addition_difficulty([0,1,1])).to eq([2,3])
    end

    it "should return 2" do
      expect(MathDifficultyHelper.compute_addition_difficulty([1,1])).to eq([2,2])
    end

    it "should return 3" do
      expect(MathDifficultyHelper.compute_addition_difficulty([1,2])).to eq([3,3])
    end

    it "should return 2" do
      expect(MathDifficultyHelper.compute_addition_difficulty([2,2])).to eq([4,2])
    end

    it "should return 5" do
      expect(MathDifficultyHelper.compute_addition_difficulty([19,9])).to eq([28,5])
    end

    it "should return 22" do
      expect(MathDifficultyHelper.compute_addition_difficulty([99999,12345])).to eq([112344,22])
    end
  end

  describe "#get_single_digit_multiplication difficulty" do
    it "should return 1" do
      expect(MathDifficultyHelper.get_single_digit_multiplication_difficulty(0,1)).to eq([0,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.get_single_digit_multiplication_difficulty(1,1)).to eq([1,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.get_single_digit_multiplication_difficulty(2,5)).to eq([10,1])
    end

    it "should return 2" do
      expect(MathDifficultyHelper.get_single_digit_multiplication_difficulty(2,7)).to eq([14,2])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.get_single_digit_multiplication_difficulty(2,6)).to eq([12,1])
    end

    it "should return 5" do
      expect(MathDifficultyHelper.get_single_digit_multiplication_difficulty(8,9)).to eq([72,5])
    end

    it "should return 4" do
      expect(MathDifficultyHelper.get_single_digit_multiplication_difficulty(8,8)).to eq([64,4])
    end
  end

  describe "#compute_simple_multiplication_difficulty" do
    it "should return 1" do
      expect(MathDifficultyHelper.compute_simple_multiplication_difficulty(1,0)).to eq([0,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_simple_multiplication_difficulty(1,1)).to eq([1,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_simple_multiplication_difficulty(2,0)).to eq([0,1])
    end

    it "should return 2" do
      expect(MathDifficultyHelper.compute_simple_multiplication_difficulty(10,1)).to eq([10,2])
    end

    it "should return 2" do
      expect(MathDifficultyHelper.compute_simple_multiplication_difficulty(15,1)).to eq([15,2])
    end

    it "should return 7" do
      expect(MathDifficultyHelper.compute_simple_multiplication_difficulty(15,5)).to eq([75,7])
    end

    it "should return 25" do
      expect(MathDifficultyHelper.compute_simple_multiplication_difficulty(999,7)).to eq([6993,25])
    end
  end

  describe "#compute_multiplication_difficulty" do
    it "should return 1" do
      expect(MathDifficultyHelper.compute_multiplication_difficulty([0,0])).to eq([0,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_multiplication_difficulty([1,0])).to eq([0,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_multiplication_difficulty([1,1])).to eq([1,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_multiplication_difficulty([2,1])).to eq([2,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_multiplication_difficulty([5,1])).to eq([5,1])
    end

    it "should return 1" do
      expect(MathDifficultyHelper.compute_multiplication_difficulty([5,2])).to eq([10,1])
    end

    it "should return 20" do
      expect(MathDifficultyHelper.compute_multiplication_difficulty([17,29])).to eq([493,20])
    end

    it "should return 31" do
      expect(MathDifficultyHelper.compute_multiplication_difficulty([17,29,3])).to eq([1479,31])
    end
  end

  describe "#compute_multiples_difficulty" do
    it "should return [50,14]" do
      expect(MathDifficultyHelper.compute_multiples_difficulty(10,5)).to eq([50,14])
    end

    it "should return [63,39]" do
      expect(MathDifficultyHelper.compute_multiples_difficulty(7,9)).to eq([63,39])
    end

    it "should return [5,14]" do
      expect(MathDifficultyHelper.compute_multiples_difficulty(1,5)).to eq([5,10])
    end

    it "should return [50,14]" do
      expect(MathDifficultyHelper.compute_multiples_difficulty(0,6)).to eq([0,5])
    end

    it "should return [50,14]" do
      expect(MathDifficultyHelper.compute_multiples_difficulty(99,3)).to eq([297,18])
    end
  end
end
