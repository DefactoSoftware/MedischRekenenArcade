class CreateUserChallenges < ActiveRecord::Migration
  def change
    create_table :user_challenges do |t|
      t.references :user
      t.references :challenge
      t.boolean :success
      t.integer :amount_fail
      t.integer :amount_good
      t.timestamps
    end
  end
end
