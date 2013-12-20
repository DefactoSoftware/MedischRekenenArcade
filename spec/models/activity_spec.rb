# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  action         :string(255)
#  trackable_id   :integer
#  trackable_type :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Activity do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:trackable) }
  end
end
