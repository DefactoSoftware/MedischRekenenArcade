require "spec_helper"

describe Friendship, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:user) }
  end
end
