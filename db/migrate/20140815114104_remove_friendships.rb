class RemoveFriendships < ActiveRecord::Migration
  def change
    drop_table :friendships
  end
end
