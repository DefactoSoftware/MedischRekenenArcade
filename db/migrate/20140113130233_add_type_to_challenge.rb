class AddTypeToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :type, :string
  end
end
