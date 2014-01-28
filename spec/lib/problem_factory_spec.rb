require 'spec_helper'

describe ProblemFactory do
  let(:challenge) { AdvancedChallenge.new(name: "PercentageOfUnit") }
  let(:user) { FactoryGirl.create(:user) }
  let(:problem_factory) { ProblemFactory.new(challenge, user) }

  it "should create a ProblemGenerator" do
    expect(problem_factory).to be_a(ProblemFactory)
  end
end

