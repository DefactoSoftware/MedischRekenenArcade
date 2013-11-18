require 'spec_helper'

describe "routing to" do
  it "to root" do
    expect(get: "/").to route_to("home#index")
  end

end
