class AddAmountOfStepsPerProblemToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :steps, :integer
  end
end
