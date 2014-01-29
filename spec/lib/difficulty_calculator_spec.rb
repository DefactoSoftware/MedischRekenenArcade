require 'spec_helper'
require 'formula'

describe FormulaDifficultyCalculator do
  OPERATORS = [:+, :-, :/, :*]
  let(:difficulty_calculator) { FormulaDifficultyCalculator.new(double) }

  describe "#compute_difficulty" do
    let(:operation1) { Operation.new(OPERATORS.sample, Constant.new(rand(50)), Constant.new(rand(50))) }
    let(:operation2) { Operation.new(OPERATORS.sample, Constant.new(operation1), Constant.new(rand(20))) }
    let(:formula) { Formula.new([operation1, operation2]) }

    it "returns an integer higher than zero" do
      expect(FormulaDifficultyCalculator.new(formula).difficulty).to be > 0
    end
  end

  describe "#compute_subtraction_difficulty" do
    it "20 - 10 is easier than 64 - 19" do
      difficultyA = SubtractionOperationDifficultyCalculator.new([2,5], [1,5]).compute_difficulty
      difficultyB = SubtractionOperationDifficultyCalculator.new([6,4], [1,8]).compute_difficulty

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_addition_difficulty" do
    it "5 + 15 is easier than 13 + 29" do
      difficultyA = AdditionOperationDifficultyCalculator.new([5], [1,5]).compute_difficulty
      difficultyB = AdditionOperationDifficultyCalculator.new([1,3], [2,9]).compute_difficulty

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_multiplication_difficulty" do
    it "10 * 1 is easier than 23 * 11" do
      difficultyA = MultiplicationOperationDifficultyCalculator.new([1,0],[1]).compute_difficulty
      difficultyB = MultiplicationOperationDifficultyCalculator.new([2,3],[1,1]).compute_difficulty

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_division" do
    it "10 / 10 is easier than 19 / 3" do
      difficultyA = DivisionOperationDifficultyCalculator.new([1,0], [1,0]).compute_difficulty
      difficultyB = DivisionOperationDifficultyCalculator.new([1,9], [3]).compute_difficulty

      expect(difficultyA).to be < difficultyB
    end
  end
end

