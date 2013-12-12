class AddUserChallengeRefToAnswer < ActiveRecord::Migration
  def change
    add_reference :answers, :user_challenge, index: true
  end
end
