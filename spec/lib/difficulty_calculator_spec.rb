require 'spec_helper'
require 'formula'

describe DifficultyCalculator do
  OPERATORS = [:+, :-, :/, :*]
  let(:difficulty_calculator) { DifficultyCalculator.new(double) }
  describe "#get_constants" do
    let(:operation) { Operation.new(OPERATORS.sample, Constant.new(Float(2993.120)), Constant.new(Float(271.201))) }
    it "returns 2 arrays of numbers" do
      expect(difficulty_calculator.get_constants(operation)).to eq([[2,9,9,3],[2,7,1]])
    end
  end

  describe "#to_int_array" do
    it "returns an array with integers" do
      expect(difficulty_calculator.to_int_array(1234)).to eq([1,2,3,4])
    end
  end

  describe "#compute_difficulty" do
    let(:operation1) { Operation.new(OPERATORS.sample, Constant.new(rand(50)), Constant.new(rand(50))) }
    let(:operation2) { Operation.new(OPERATORS.sample, Constant.new(operation1), Constant.new(rand(20))) }
    let(:formula) { Formula.new([operation1, operation2]) }

    it "returns an integer higher than zero" do
      expect(DifficultyCalculator.new(formula).compute_difficulty).to be > 0
    end
  end

  describe "#compute_step" do
    let(:difficulty_calculator) { DifficultyCalculator.new(double) }

    it "calls compute_addition_difficulty" do
      expect(difficulty_calculator).to receive(:compute_addition_difficulty)
      difficulty_calculator.compute_step(:+, [rand(10), rand(10)], [rand(10), rand(10)])
    end

    it "calls compute_subtraction_difficulty" do
      expect(difficulty_calculator).to receive(:compute_subtraction_difficulty)
      difficulty_calculator.compute_step(:-, [rand(10), rand(10)], [rand(10), rand(10)])
    end

    it "calls compute_multiplication_difficulty" do
      expect(difficulty_calculator).to receive(:compute_multiplication_difficulty)
      difficulty_calculator.compute_step(:*, [rand(10), rand(10)], [rand(10), rand(10)])
    end

    it "calls compute_division_difficulty" do
      expect(difficulty_calculator).to receive(:compute_division_difficulty)
      difficulty_calculator.compute_step(:/, [rand(10), rand(10)], [rand(10), rand(10)])
    end
  end

  describe "#compute_subtraction_difficulty" do
    it "20 - 10 should be easier than 64 - 19" do
      difficultyA = difficulty_calculator.compute_subtraction_difficulty([2,5], [1,5])
      difficultyB = difficulty_calculator.compute_subtraction_difficulty([6,4], [1,8])

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_addition_difficulty" do
    it "5 + 15 should be easier than 13 + 29" do
      difficultyA = difficulty_calculator.compute_addition_difficulty([5], [1,5])
      difficultyB = difficulty_calculator.compute_addition_difficulty([1,3], [2,9])

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_multiplication_difficulty" do
    it "10 * 1 should be easier than 23 * 11" do
      difficultyA = difficulty_calculator.compute_multiplication_difficulty([1,0],[1])
      difficultyB = difficulty_calculator.compute_multiplication_difficulty([2,3],[1,1])

      expect(difficultyA).to be < difficultyB
    end
  end

  describe "#compute_division" do
    it "10 / 10 should be easier than 19 / 3" do
      difficultyA = difficulty_calculator.compute_division_difficulty([1,0], [1,0])
      difficultyB = difficulty_calculator.compute_division_difficulty([1,9], [3])

      expect(difficultyA).to be < difficultyB
    end
  end
end

