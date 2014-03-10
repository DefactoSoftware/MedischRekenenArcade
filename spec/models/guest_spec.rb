require 'spec_helper'

describe Guest do
  let(:guest) { Guest.new }

  it "has a name method" do
    expect(Guest).to have_method :name
  end

  it "has a guest? method" do
    expect(Guest).to have_method :guest?
  end

  it "has a user_challenges method" do
    expect(Guest).to have_method :user_challenges
  end

  it "has a badges method" do
    expect(Guest).to have_method :badges
  end

  it "has an answers method" do
    expect(Guest).to have_method :answers
  end
end
