require 'spec_helper'

describe FeedbackReport do
  describe "Associations" do
    it { should belong_to(:user) }
  end
end
