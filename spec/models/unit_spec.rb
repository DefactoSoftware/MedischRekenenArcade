# == Schema Information
#
# Table name: units
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  sign          :string(255)
#  unit_group_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Unit do
  pending "add some examples to (or delete) #{__FILE__}"
end
