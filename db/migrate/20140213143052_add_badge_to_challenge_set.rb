class AddBadgeToChallengeSet < ActiveRecord::Migration
  def change
    add_column :challenge_sets, :badge, :integer
  end
end
