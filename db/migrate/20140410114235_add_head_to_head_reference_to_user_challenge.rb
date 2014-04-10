class AddHeadToHeadReferenceToUserChallenge < ActiveRecord::Migration
  def change
    add_reference :user_challenges, :head_to_head_challenge
  end
end
