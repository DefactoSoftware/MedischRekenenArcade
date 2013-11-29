class AssignUnitGroupToProblem < ActiveRecord::Migration
  def change
    change_table :problems do |t|
      t.references :unit
    end
  end
end
