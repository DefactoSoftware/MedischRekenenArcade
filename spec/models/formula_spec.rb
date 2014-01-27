require 'spec_helper'

describe Formula do
  it "should return 3 on 1+2" do
    operation = Operation.new(:+, Constant.new(1), Constant.new(2))
    formula = Formula.new([operation])
    expect(formula.result).to eq(3.0)
  end

  it "should return 7 on 1+2*3" do
    operation1 = Operation.new(:*, Constant.new(2), Constant.new(3))
    operation2 = Operation.new(:+, Constant.new(operation1), Constant.new(1))
    formula = Formula.new([operation1, operation2])
    expect(formula.result).to eq(7.0)
  end

  it "should return a string containing 2 * 3 \r\n  6 + 1" do
    operation1 = Operation.new(:*, Constant.new(2), Constant.new(3))
    operation2 = Operation.new(:+, Constant.new(operation1), Constant.new(1))
    formula = Formula.new([operation1, operation2])
    expect(formula.text).to eq("2 * 3 \n 6 + 1")
  end

  describe "difficulty" do
    operators = [:+, :-, :*, :/]
    let(:operation1) { Operation.new(operators.sample, rand(50), rand(50)) }
    let(:operation2) { Operation.new(operators.sample, operation1, rand(50))}
    let(:operation3) { Operation.new(operators.sample, operation2, rand(50))}

    let(:formula) { [operation1, operation2, operation3 ] }

    it "should calculate a difficulty for the formula" do
      expect(formula.get_difficulty).to be > 0
    end
  end
end



describe Operation do
    it "can add two integers" do
      expect(Operation.new(:+, Constant.new(2),Constant.new(1)).result).to eq(3.0)
    end

    it "can divide two integers" do
      expect(Operation.new(:/, Constant.new(4),Constant.new(2)).result).to eq(2.0)
    end

    it "can multiply two integers" do
      expect(Operation.new(:*, Constant.new(2),Constant.new(3)).result).to eq(6.0)
    end

    it "can subtract two integers" do
      expect(Operation.new(:-, Constant.new(2),Constant.new(1)).result).to eq(1.0)
    end

    it "can add two floats" do
      expect(Operation.new(:+, Constant.new(2.5),Constant.new(3.3)).result).to eq(5.8)
    end

    it "can divide two floats" do
      expect(Operation.new(:/, Constant.new(2.5),Constant.new(1.5)).result).to eq(1.67)
    end

    it "can multiply two floats" do
      expect(Operation.new(:*, Constant.new(1.5),Constant.new(5.0)).result).to eq(7.5)
    end

    it "can subtract two floats" do
      expect(Operation.new(:-, Constant.new(2.8),Constant.new(1.5)).result).to eq(1.3)
    end

    describe "to_s" do
      it "should return a string containing 2 + 1" do
        expect(Operation.new(:+, Constant.new(2),Constant.new(1)).text).to eq("2 + 1")
      end
    end
  end

describe Constant do
  it "should return result of operation if value1 is operation" do
    operation = Operation.new(:+, Constant.new(2), Constant.new(1))
    expect(Constant.new(operation).value).to eq(3)
  end

  it "should return value if value is not operation" do
    expect(Constant.new(4).value).to eq(4)
  end
end

# * / + -


