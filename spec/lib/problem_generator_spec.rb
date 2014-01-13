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
  end

end
