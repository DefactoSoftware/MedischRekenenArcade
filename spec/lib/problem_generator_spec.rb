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
      let(:challenge_percentage_two) { AdvancedChallenge.new(name: "Percentages 2") }
      let(:challenge_percentage_three) { AdvancedChallenge.new(name: "Percentages 3") }

      describe "challenge percentage one" do
        let(:challenge) { AdvancedChallenge.new(name: "Percentages 1") }
        let(:problem_generator) { ProblemGeneratorFactory.new(challenge).build }

        it "should create a percentage one problem_generator" do
          expect(problem_generator).to be_a(PercentageProblemGeneratorOne)
        end

        it "should generate a problem" do
          expect(problem_generator.problem).to be_a(Problem)
        end

        describe "#problem" do
          it "should have a theory" do
            expect(problem_generator.problem.theory).to be_a(String)
          end

          it "should have a formula" do
            expect(problem_generator.problem.formula).to be_a(String)
          end

          it "should have a result" do
            expect(problem_generator.problem.get_result).to be_a(Float)
          end
        end
      end

      describe "challenge percentage two" do
        let(:challenge) { AdvancedChallenge.new(name: "Percentages 2") }
        let(:problem_generator) { ProblemGeneratorFactory.new(challenge).build }

        it "should create a percentage two problem_generator" do
          expect(problem_generator).to be_a(PercentageProblemGeneratorTwo)
        end

        it "should generate a problem" do
          expect(problem_generator.problem).to be_a(Problem)
        end
      end

      describe "challenge percentage three" do
        let(:challenge) { AdvancedChallenge.new(name: "Percentages 3") }
        let(:problem_generator) { ProblemGeneratorFactory.new(challenge).build }

        it "should create a percentage three problem_generator" do
          expect(problem_generator).to be_a(PercentageProblemGeneratorThree)
        end

        it "should generate a problem" do
          expect(problem_generator.problem).to be_a(Problem)
        end
      end
    end
  end
end
