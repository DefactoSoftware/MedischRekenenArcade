require 'spec_helper'

describe ProblemGenerator do
  let(:challenge) { AdvancedChallenge.new() }
  let(:problem_generator) { ProblemGenerator.new(challenge) }

  it "should create a ProblemGenerator" do
    expect(problem_generator).to be_a(ProblemGenerator)
  end

  it "should have a challenge" do
    expect(problem_generator.challenge).to eq(challenge)
  end

  describe ProblemGeneratorFactory do
    let(:problem_generator) { ProblemGeneratorFactory.new(challenge).build }

    it "should create a ProblemGenerator" do
      expect(problem_generator).to be_a(ProblemGenerator)
    end

    it "should have a challenge" do
      expect(problem_generator.challenge).to eq(challenge)
    end

    describe "Percentage challenges" do
      let(:challenge_percentage_one) { AdvancedChallenge.new(name: "Percentages 1") }
      let(:challenge_percentage_two) { AdvancedChallenge.new(name: "Percentages 2") }
      let(:challenge_percentage_three) { AdvancedChallenge.new(name: "Percentages 3") }

      it "should create a percentage one problem_generator" do
        problem_generator = ProblemGeneratorFactory.new(challenge_percentage_one).build
        expect(problem_generator).to be_a(PercentageProblemGeneratorOne)
      end

      it "should create a percentage two problem_generator" do
        problem_generator = ProblemGeneratorFactory.new(challenge_percentage_two).build
        expect(problem_generator).to be_a(PercentageProblemGeneratorTwo)
      end

      it "should create a percentage three problem_generator" do
        problem_generator = ProblemGeneratorFactory.new(challenge_percentage_three).build
        expect(problem_generator).to be_a(PercentageProblemGeneratorThree)
      end
    end
  end
end
