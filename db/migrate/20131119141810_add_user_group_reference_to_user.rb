class AddUserGroupReferenceToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :user_group, index: true
    end
  end
end
