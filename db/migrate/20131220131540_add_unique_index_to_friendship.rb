class AddUniqueIndexToFriendship < ActiveRecord::Migration
  def change
    add_index :friendships, [:friend_id, :user_id], unique: true
  end
end
