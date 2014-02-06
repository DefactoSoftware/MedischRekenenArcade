class AddUnitQuestionToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :unit_question, :string
  end
end
