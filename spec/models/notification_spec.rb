# == Schema Information
#
# Table name: notifications
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  image          :string(255)
#  text           :string(255)
#  trackable_id   :integer
#  trackable_type :string(255)
#  notified       :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Notification do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:trackable) }
  end
end
