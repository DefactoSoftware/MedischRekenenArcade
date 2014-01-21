class AddChallengeSetReferenceToChallenge < ActiveRecord::Migration
  def change
    add_reference :challenges, :challenge_set
  end
end
