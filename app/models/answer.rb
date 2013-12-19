# == Schema Information
#
# Table name: answers
#
#  id                :integer          not null, primary key
#  value             :float
#  user_id           :integer
#  problem_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  user_challenge_id :integer
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem
  belongs_to :user_challenge

  def is_correct?
     value.round(2) == problem.get_result.round(2)
  end
end
