# == Schema Information
#
# Table name: unit_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe UnitGroup do
  describe "Associations" do
    it { should have_many(:units) }
  end
end
