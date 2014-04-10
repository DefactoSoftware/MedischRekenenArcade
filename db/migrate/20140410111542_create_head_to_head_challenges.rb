class CreateHeadToHeadChallenges < ActiveRecord::Migration
  def change
    create_table :head_to_head_challenges do |t|
      t.integer :challenger_id
      t.integer :challenged_id
      t.integer :challenge_id
      t.integer :points_bet
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
