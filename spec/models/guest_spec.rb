require 'spec_helper'

describe Guest do
  let(:guest) { Guest.new }

  it "has a name method" do
    expect(Guest).to have_method :name
  end

  it "has a guest? method" do
    expect(Guest).to have_method :guest?
  end
end
