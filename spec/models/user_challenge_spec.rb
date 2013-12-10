# == Schema Information
#
# Table name: user_challenges
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  challenge_id :integer
#  success      :boolean
#  amount_fail  :integer
#  amount_good  :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe UserChallenge do
  pending "add some examples to (or delete) #{__FILE__}"
end
