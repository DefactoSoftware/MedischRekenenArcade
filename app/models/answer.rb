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
#  feedback          :string(255)
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :problem
  belongs_to :user_challenge

  alias_method :actual_user, :user

  def user
    actual_user || Guest.new
  end

  def correct?
    eval_answer
  end

  def eval_answer
    if value.round(2) == problem.result.round(2)
      self.feedback = I18n.t("answer.feedback.correct")
      true
    else
      eval_answer_deep
    end
  end

  def eval_answer_deep
    if (value / 10).round(2) == problem.result.round(2) ||
       (value / 100).round(2) == problem.result.round(2) ||
       (value / 1000).round(2) == problem.result.round(2)
      self.feedback = I18n.t("answer.feedback.conversion")
      false
    elsif (value * 10).round(2) == problem.result.round(2) ||
          (value * 100).round(2) == problem.result.round(2) ||
          (value * 1000).round(2) == problem.result.round(2)
      self.feedback = I18n.t("answer.feedback.conversion")
      false
    elsif ((value - 0.2)..(value + 0.2)).include?(problem.result)
      self.feedback = I18n.t("answer.feedback.rounding2")
      true
    elsif value == problem.result ||
          ((value - 1.0)..(value + 1.0)).include?(problem.result)
      self.feedback = I18n.t("answer.feedback.rounding")
      false
    else
      self.feedback = I18n.t("answer.feedback.wrong")
      false
    end
  end
end
