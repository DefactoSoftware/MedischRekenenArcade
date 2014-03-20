require 'spec_helper'

describe Guest do
  let(:guest) { Guest.new }

  it "has an id method" do
    expect(Guest).to have_method :id
  end

  it "has a name method" do
    expect(Guest).to have_method :name
  end

  it "has a guest? method" do
    expect(Guest).to have_method :guest?
  end

  it "has a username method" do
    expect(Guest).to have_method :username
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

  it "has a user_skills method" do
    expect(Guest).to have_method :user_skills
  end

  it "has a _sash method" do
    expect(Guest).to have_method :_sash
  end
end
