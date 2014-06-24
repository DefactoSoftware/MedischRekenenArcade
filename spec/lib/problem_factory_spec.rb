require "spec_helper"

describe ProblemFactory do
  let(:challenge) { Challenge.new(name: "PercentageOfUnit") }
  let(:user) { create(:user) }
  let(:problem_factory) { ProblemFactory.new(challenge, user) }

  it "should create a ProblemGenerator" do
    expect(problem_factory).to be_a(ProblemFactory)
  end
end
