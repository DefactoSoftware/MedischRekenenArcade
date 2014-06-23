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
#  notified       :boolean          default(FALSE)
#

require 'spec_helper'

describe Activity, :type => :model do
  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:trackable) }
  end
end
