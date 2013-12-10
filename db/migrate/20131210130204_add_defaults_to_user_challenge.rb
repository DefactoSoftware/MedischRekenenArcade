class AddDefaultsToUserChallenge < ActiveRecord::Migration
  def change
    change_column_default(:user_challenges, :amount_fail, 0)
    change_column_default(:user_challenges, :amount_good, 0)
  end
end
