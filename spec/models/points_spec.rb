require 'spec_helper'

describe Point do
  let(:user) { FactoryGirl.create(:user) }

  describe "Associations" do
    it { should belong_to(:user) }
  end

  describe "Increasing points" do
    it "should increase total by 2" do
      Point.increase(2, user)
      expect(user.total_points).to eq(2)
    end

    it "should increase default value (1)" do
      Point.increase(user)
      expect(user.total_points).to eq(1)
    end
  end

  describe "Decrease points" do
    it "should decrease total by 2" do
      Point.decrease(2, user)
      expect(user.total_points).to eq(-2)
    end

    it "should decrease default value (1)" do
      Point.decrease(user)
      expect(user.total_points).to eq(-1)
    end
  end

end
