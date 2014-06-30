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
#  title          :string(255)      default("Notification")
#

require "spec_helper"

describe Notification, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:trackable) }
  end
end
