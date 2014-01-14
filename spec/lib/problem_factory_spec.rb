require 'spec_helper'

describe ProblemFactory do
  let(:challenge) { AdvancedChallenge.new(name: "PercentageOfUnit") }
  let(:problem_factory) { ProblemFactory.new(challenge) }

  it "should create a ProblemGenerator" do
    expect(problem_factory).to be_a(ProblemFactory)
  end

  describe Problem do
    describe PercentageAmountOfAmount do
      let(:challenge) { AdvancedChallenge.new(name: "PercentageAmountOfAmount") }
      let(:problem_factory) { ProblemFactory.new(challenge) }

      it "should create a problem" do
        expect(problem_factory.problem).to be_a(PercentageAmountOfAmount)
      end

      describe "problem" do
        it "should have a theory" do
          expect(problem_factory.problem.theory).to be_a(String)
        end

        it "should have a result" do
          expect(problem_factory.problem.get_result).to be_a(Float)
        end

        it "should have a formula" do
          expect(problem_factory.problem.formula).to be_a(String)
        end
      end
    end

    describe PercentageOfUnit do
      let(:challenge) { AdvancedChallenge.new(name: "PercentageOfUnit") }
      let(:problem_factory) { ProblemFactory.new(challenge) }

      it "should create a problem" do
        expect(problem_factory.problem).to be_a(PercentageOfUnit)
      end

      describe "problem" do
        it "should have a theory" do
          expect(problem_factory.problem.theory).to be_a(String)
        end

        it "should have a result" do
          expect(problem_factory.problem.get_result).to be_a(Float)
        end

        it "should have a formula" do
          expect(problem_factory.problem.formula).to be_a(String)
        end
      end
    end
    describe PercentageUnitToHundred do
      let(:challenge) { AdvancedChallenge.new(name: "PercentageUnitToHundred") }
      let(:problem_factory) { ProblemFactory.new(challenge) }

      it "should create a problem" do
        expect(problem_factory.problem).to be_a(PercentageUnitToHundred)
      end

      describe "problem" do
        it "should have a theory" do
          expect(problem_factory.problem.theory).to be_a(String)
        end

        it "should have a result" do
          expect(problem_factory.problem.get_result).to be_a(Float)
        end

        it "should have a formula" do
          expect(problem_factory.problem.formula).to be_a(String)
        end
      end
    end
  end
end

