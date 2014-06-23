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

describe Unit, :type => :model do
  describe "Associations" do
    it { is_expected.to belong_to(:unit_group) }
  end
end
