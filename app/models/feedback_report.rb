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

class FeedbackReport < ActiveRecord::Base
  belongs_to :user
end
