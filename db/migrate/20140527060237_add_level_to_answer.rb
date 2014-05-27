class AddLevelToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :level, :integer
  end
end
