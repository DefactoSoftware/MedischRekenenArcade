# == Schema Information
#
# Table name: step_variables
#
#  id          :integer          not null, primary key
#  step_id     :integer
#  variable_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class StepVariable < ActiveRecord::Base
  belongs_to :step
  belongs_to :variable
end
