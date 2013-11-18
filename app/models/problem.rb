# == Schema Information
#
# Table name: problems
#
#  id         :integer          not null, primary key
#  formula    :string(255)
#  question   :string(255)
#  theory     :string(255)
#  difficulty :float
#  unit       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Problem < ActiveRecord::Base
  has_many :steps
  has_many :skills, through: :steps

  def generate_1
    problem = self.create(question: "How much is 1 + 1?")
    difficulty = 1
    difficulty.times do
      Step.create()
    end
  end


end
