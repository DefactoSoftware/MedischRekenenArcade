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

require 'spec_helper'

describe Problem do
  pending "add some examples to (or delete) #{__FILE__}"
end
