require 'spec_helper'
include MathDifficultyHelper

describe "MathDifficultyHelper" do
  describe "#compute_subtraction_difficulty" do
    it "20 - 10 should be easier than 64 - 19" do
      difficultyA = MathDifficultyHelper.compute_subtraction_difficulty([2,5], [1,5])
      difficultyB = MathDifficultyHelper.compute_subtraction_difficulty([6,4], [1,8])

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_addition_difficulty" do
    it "5 + 15 should be easier than 13 + 29" do
      difficultyA = MathDifficultyHelper.compute_addition_difficulty([5], [1,5])
      difficultyB = MathDifficultyHelper.compute_addition_difficulty([1,3], [2,9])

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_multiplication_difficulty" do
    it "10 * 1 should be easier than 23 * 11" do
      difficultyA = MathDifficultyHelper.compute_multiplication_difficulty([1,0],[1])
      difficultyB = MathDifficultyHelper.compute_multiplication_difficulty([2,3],[1,1])

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_division" do
    it "10 / 10 should be easier than 19 / 3" do
      difficultyA = MathDifficultyHelper.compute_division_difficulty([1,0], [1,0])
      difficultyB = MathDifficultyHelper.compute_division_difficulty([1,9], [3])

      expect(difficultyA).to be < difficultyB
    end
  end
end
