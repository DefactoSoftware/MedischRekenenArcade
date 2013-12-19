class ChangeTheoryStringIntoText < ActiveRecord::Migration
  def change
    change_table :problems do |t|
    t.change :theory, :text
  end
  end
end
