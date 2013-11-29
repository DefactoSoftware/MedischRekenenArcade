require 'spec_helper'

describe Point do
  describe "Associations" do
    it { should belong_to(:user) }
  end
end
