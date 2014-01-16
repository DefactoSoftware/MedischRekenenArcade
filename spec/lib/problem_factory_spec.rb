require 'spec_helper'

describe ProblemFactory do
  let(:challenge) { AdvancedChallenge.new(name: "PercentageOfUnit") }
  let(:problem_factory) { ProblemFactory.new(challenge) }

  it "should create a ProblemGenerator" do
    expect(problem_factory).to be_a(ProblemFactory)
  end
end

