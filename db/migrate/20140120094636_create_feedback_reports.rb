class CreateFeedbackReports < ActiveRecord::Migration
  def change
    create_table :feedback_reports do |t|
      t.references :user,
      t.text :text
      t.string :subject
      t.string :page
      t.timestamps
    end
  end
end
