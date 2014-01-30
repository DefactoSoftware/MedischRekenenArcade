class AddSkillReferenceToProblems < ActiveRecord::Migration
  def change
    change_table :problems do |t|
      t.references :skill, index: true
    end
  end
end
