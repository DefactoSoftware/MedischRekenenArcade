# == Schema Information
#
# Table name: feedback_reports
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  text       :text
#  subject    :string(255)
#  page       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe FeedbackReport do
  describe "Associations" do
    it { should belong_to(:user) }
  end
end
